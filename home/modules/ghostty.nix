{lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.runCommand "ghostty-dummy" {} "mkdir -p $out";
    settings = {
      font-size = lib.mkForce 14;
      macos-titlebar-style = "hidden";
      window-padding-x = 8;
      window-padding-y = 4;
      macos-option-as-alt = true;
      background-opacity = 0.8;
      # quick-terminal-position = "center";
      # quick-terminal-size = "300px";
      # keybind = [
      #   "global:alt+space=toggle_quick_terminal"
      # ];
    };
  };
}
