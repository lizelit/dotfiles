{ ... }:

{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];
  programs.nixvim = {
    enable = true;

    colorschemes.kanagawa = {
      enable = true;
    };

    colorschemes.nord = {
      enable = false;
    };
  };
}
