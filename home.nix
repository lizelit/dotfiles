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

    # 最小限のパッケージ
    packages = with pkgs; [
      # ここに必要なパッケージを追加
      # 例:
      # curl
      # git
      # fzf
    ];
  };

  # Neovim設定 (まずは通常のNeovimで試す)
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;  # 一時的に通常のneovimを使用
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # プラグインなし、基本設定のみ
    extraLuaConfig = ''
      -- 基本設定のみ
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

  # Git設定（最小限）
  programs.git = {
    enable = true;
    userName = "lizelit";  # 実際の名前に変更
    userEmail = "your.email@example.com";  # 実際のメールアドレスに変更
    
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  # Zsh設定（基本のみ）
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
