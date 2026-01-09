{ pkgs,username, ... }:

{
  home-manager.users.${username} = {
    stylix.targets.helix.enable = false;
    stylix.tergets.nixvim.enable = false;
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
      };
    };
  };
}
