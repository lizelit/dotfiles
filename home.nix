{ config, pkgs, inputs, username ? "lizelit", homeDirectory ? "/Users/lizelit", ... }:

{
  # Home Manager基本設定
  home = {
    inherit username homeDirectory;
    stateVersion = "24.05";  # より最近のバージョンに更新

    # 環境変数
    sessionVariables = {
      EDITOR = "nvim";
    };

    # 一時的にパッケージを無効化
    packages = [ ];
  };

  # 一時的に通常のNeovimを使用
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;  # nightlyではなく通常版
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.g.mapleader = " "
    '';
  };

  # Git設定
  programs.git = {
    enable = true;
    userName = "lizelit";
    userEmail = "your.email@example.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  # 基本的なZsh設定
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      dr = "darwin-rebuild switch --flake ~/dotfiles";
    };
  };
}
