# nvim/default.nix
{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    
    # ... (Neovimの各種設定をここに記述)
    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
    };

    plugins = {
      # ... (プラグイン設定)
    };
    
    # ...
  };
}
