{ pkgs,username, ... }:

{
  home-manager.users.${username} = {
    stylix.targets.helix.enable = false;
    stylix.targets.nixvim.enable = false;
    stylix.targets.ghostty.enable = false;
  };

  stylix = {
    enable = true;

    image = ../../pics/wallpaper.jpg;

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    opacity.terminal = 0.8;
    opacity.applications = 0.8;
    opacity.popups = 0.8;
    opacity.desktop = 0.8;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "UDEV Gothic NFLG";
      };
      sizes = {
        terminal = 12;
        applications = 12;
        desktop = 12;
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
