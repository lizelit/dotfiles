{ ... }:

let
  btopThemeDir = ../config/btop/themes;
in
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox";
    };

    themes = {
      gruvbox = builtins.readFile "${btopThemeDir}/gruvbox.theme";
    };
  };
}
