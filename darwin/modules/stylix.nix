{ pkgs,username, ... }:

{
  home-manager.users.${username} = {
    stylix.targets.helix.enable = false;
    stylix.targets.nixvim.enable = false;
    # stylix.targets.rio.enable = false;
  };

  stylix = {
    enable = true;

    image = ../../pics/wallpaper.jpg;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
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
