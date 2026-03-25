{lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.runCommand "ghostty-dummy" {} "mkdir -p $out";
    settings = {
      font-size = lib.mkForce 12.5;
      macos-titlebar-style = "hidden";
      window-padding-x = 8;
      window-padding-y = 4;
      macos-option-as-alt = true;
      quick-terminal-position = "top";

      keybind = [
        "global:alt+space=toggle_quick_terminal"
      ];
    };
  };
}
