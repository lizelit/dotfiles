local wezterm = require 'wezterm'

local wezterm = require 'wezterm'

for name, _ in pairs(wezterm.get_builtin_color_schemes()) do
  wezterm.log_info("Color scheme available: " .. name)
end

return {
  color_scheme = "Everforest Dark (Medium)",  -- ここを好きなバリエーションに
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 14.0,
  hide_tab_bar_if_only_one_tab = true,
  window_background_opacity = 0.9,
  macos_window_background_blur = 20,
  front_end = "WebGpu",
}

