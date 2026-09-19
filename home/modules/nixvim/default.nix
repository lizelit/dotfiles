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

    extraPackages = [
      (pkgs.python3.withPackages (ps: [ps.pynvim]))
    ];

    colorschemes.kanagawa = {
      enable = false;
    };

    colorschemes.nord = {
      enable = false;
    };

    colorschemes.everforest = {
      enable = true;
    };
  };
}
