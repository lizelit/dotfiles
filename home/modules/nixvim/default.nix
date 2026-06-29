{ pkgs, ... }:

{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];
  programs.nixvim = {
    enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      Coqtail
    ];

    colorschemes.kanagawa = {
      enable = true;
    };

    colorschemes.nord = {
      enable = false;
    };
  };
}
