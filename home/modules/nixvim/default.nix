{ pkgs, ... }:

{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    extraPlugins = with pkgs.vimPlugins; [
      Coqtail nordic-nvim
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
      enable = false;
    };

    colorschemes.kanagawa-paper.enable = false;

    colorscheme = "nordic";
  };
}
