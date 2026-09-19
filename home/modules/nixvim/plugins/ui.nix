{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    zen-mode.enable = true;
    noice.enable = true;
    lualine.enable = true;
    which-key.enable = true;
    which-key.settings = {
      delay = 1;
    };
  };
}
