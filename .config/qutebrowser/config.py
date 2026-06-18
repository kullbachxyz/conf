# qutebrowser config — Catppuccin Mocha
# https://qutebrowser.org/doc/help/configuring.html

config.load_autoconfig(False)

# ── Catppuccin Mocha palette ─────────────────────────────────────────────────
base     = "#1e1e2e"
mantle   = "#181825"
crust    = "#11111b"
surface0 = "#313244"
surface1 = "#45475a"
surface2 = "#585b70"
overlay0 = "#6c7086"
overlay1 = "#7f849c"
overlay2 = "#9399b2"
subtext0 = "#a6adc8"
subtext1 = "#bac2de"
text     = "#cdd6f4"
lavender = "#b4befe"
blue     = "#89b4fa"
sapphire = "#74c7ec"
sky      = "#89dceb"
teal     = "#94e2d5"
green    = "#a6e3a1"
yellow   = "#f9e2af"
peach    = "#fab387"
maroon   = "#eba0ac"
red      = "#f38ba8"
mauve    = "#cba6f7"
pink     = "#f5c2e7"
flamingo = "#f2cdcd"

# ── Completion ───────────────────────────────────────────────────────────────
c.colors.completion.fg                          = text
c.colors.completion.odd.bg                      = base
c.colors.completion.even.bg                     = mantle
c.colors.completion.category.fg                 = lavender
c.colors.completion.category.bg                 = mantle
c.colors.completion.category.border.top         = mantle
c.colors.completion.category.border.bottom      = surface0
c.colors.completion.item.selected.fg            = text
c.colors.completion.item.selected.bg            = surface1
c.colors.completion.item.selected.border.top    = surface1
c.colors.completion.item.selected.border.bottom = surface1
c.colors.completion.item.selected.match.fg      = peach
c.colors.completion.match.fg                    = peach
c.colors.completion.scrollbar.fg                = overlay0
c.colors.completion.scrollbar.bg                = mantle

# ── Downloads ────────────────────────────────────────────────────────────────
c.colors.downloads.bar.bg   = mantle
c.colors.downloads.start.fg = base
c.colors.downloads.start.bg = blue
c.colors.downloads.stop.fg  = base
c.colors.downloads.stop.bg  = green
c.colors.downloads.error.fg = red
c.colors.downloads.error.bg = base

# ── Hints ────────────────────────────────────────────────────────────────────
c.colors.hints.fg       = base
c.colors.hints.bg       = yellow
c.colors.hints.match.fg = peach

# ── Key hints ────────────────────────────────────────────────────────────────
c.colors.keyhint.fg        = text
c.colors.keyhint.suffix.fg = lavender
c.colors.keyhint.bg        = f"{mantle}cc"

# ── Messages ─────────────────────────────────────────────────────────────────
c.colors.messages.error.fg     = base
c.colors.messages.error.bg     = red
c.colors.messages.error.border = maroon

c.colors.messages.warning.fg     = base
c.colors.messages.warning.bg     = yellow
c.colors.messages.warning.border = peach

c.colors.messages.info.fg     = text
c.colors.messages.info.bg     = surface0
c.colors.messages.info.border = surface1

# ── Prompts ──────────────────────────────────────────────────────────────────
c.colors.prompts.fg          = text
c.colors.prompts.bg          = surface0
c.colors.prompts.border      = f"1px solid {surface1}"
c.colors.prompts.selected.fg = text
c.colors.prompts.selected.bg = surface2

# ── Statusbar ────────────────────────────────────────────────────────────────
c.colors.statusbar.normal.fg      = text
c.colors.statusbar.normal.bg      = mantle

c.colors.statusbar.insert.fg      = base
c.colors.statusbar.insert.bg      = green

c.colors.statusbar.passthrough.fg = base
c.colors.statusbar.passthrough.bg = sapphire

c.colors.statusbar.private.fg     = text
c.colors.statusbar.private.bg     = surface1

c.colors.statusbar.command.fg     = text
c.colors.statusbar.command.bg     = mantle

c.colors.statusbar.command.private.fg = text
c.colors.statusbar.command.private.bg = surface1

c.colors.statusbar.caret.fg           = base
c.colors.statusbar.caret.bg           = mauve
c.colors.statusbar.caret.selection.fg = base
c.colors.statusbar.caret.selection.bg = lavender

c.colors.statusbar.progress.bg = blue

c.colors.statusbar.url.fg              = text
c.colors.statusbar.url.error.fg        = red
c.colors.statusbar.url.hover.fg        = sky
c.colors.statusbar.url.success.http.fg = peach
c.colors.statusbar.url.success.https.fg = green
c.colors.statusbar.url.warn.fg         = yellow

# ── Tabs ─────────────────────────────────────────────────────────────────────
c.colors.tabs.bar.bg = crust

c.colors.tabs.indicator.start = blue
c.colors.tabs.indicator.stop  = green
c.colors.tabs.indicator.error = red

c.colors.tabs.odd.fg  = subtext0
c.colors.tabs.odd.bg  = mantle
c.colors.tabs.even.fg = subtext0
c.colors.tabs.even.bg = base

c.colors.tabs.selected.odd.fg  = text
c.colors.tabs.selected.odd.bg  = surface0
c.colors.tabs.selected.even.fg = text
c.colors.tabs.selected.even.bg = surface0

c.colors.tabs.pinned.odd.fg  = green
c.colors.tabs.pinned.odd.bg  = mantle
c.colors.tabs.pinned.even.fg = green
c.colors.tabs.pinned.even.bg = base

c.colors.tabs.pinned.selected.odd.fg  = green
c.colors.tabs.pinned.selected.odd.bg  = surface0
c.colors.tabs.pinned.selected.even.fg = green
c.colors.tabs.pinned.selected.even.bg = surface0

# ── Web page ─────────────────────────────────────────────────────────────────
c.colors.webpage.bg                     = base
c.colors.webpage.preferred_color_scheme = "dark"
