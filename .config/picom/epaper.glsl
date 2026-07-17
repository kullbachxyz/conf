#version 330
// E-Paper look for picom v13 (window-shader-fg / root-pixmap-shader)
// Grayscale + gentle contrast + warm paper tint + optional quantization.
in vec2 texcoord;                 // texture coordinate (in pixels)
uniform sampler2D tex;            // texture of the window

vec4 default_post_processing(vec4 c);

// --- tweak these ---
const float CONTRAST = 1.15;                    // 1.0 = none
const float LEVELS   = 16.0;                    // e-ink shades; 256 ~= disable
const vec3  PAPER     = vec3(1.00, 0.98, 0.93); // warm white point; vec3(1.0) = neutral

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 c = texture2D(tex, texcoord / texsize, 0);

    // luminance -> grayscale (Rec.709)
    float y = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));

    // contrast around mid-gray
    y = clamp((y - 0.5) * CONTRAST + 0.5, 0.0, 1.0);

    // quantize to N levels for the segmented e-ink feel
    y = floor(y * LEVELS + 0.5) / LEVELS;

    // warm paper tint
    c.rgb = y * PAPER;

    return default_post_processing(c);
}
