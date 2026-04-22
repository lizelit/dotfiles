{ ... }:

{
  xdg.configFile."ghostty/config" = {
    text = ''
      font-family = "UDEV Gothic NFLG"
      font-size = 14
      macos-titlebar-style = "hidden"
      window-padding-x = 8
      window-padding-y = 4
      macos-option-as-alt = true
      background-opacity = 0.8
      background-blur = true
    '';
  };
}
