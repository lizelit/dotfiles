{ config, pkgs, inputs, username ? "lizelit", homeDirectory ? "/Users/lizelit", ... }:

{
  # Home Manager設定
  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";

    # 環境変数
    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      # 必要なパッケージを追加
      # 例:
      # curl
      # git
      # fzf
    ];
  };

  # Neovim Nightly設定
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # プラグインなし、基本設定のみ
    extraLuaConfig = ''
      -- 基本設定
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = true
      vim.opt.termguicolors = true
      
      -- リーダーキー設定
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

  # Zsh設定
  programs.zsh = {
    enable = true;
    
    shellAliases = {
      # 基本的なエイリアス
      ll = "ls -la";
      
      # Nix/Darwin エイリアス
      dr = "darwin-rebuild switch --flake ~/dotfiles";
      hm = "home-manager switch --flake ~/dotfiles";
    };
  };
}
