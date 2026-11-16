{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    noice.enable = true;
  };
}
