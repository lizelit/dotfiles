local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Everforest Dark Medium (Gogh)'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

return config
