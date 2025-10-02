{ config, lib, pkgs, home, ... }:

{
  home.stateVerson = "24.05";
  # 基本パッケージ
  home.packages = with pkgs; [
    ripgrep
    fd
    git
    gcc
    nodejs
    tree
    wget
    curl
  ];

  # NixVim設定
  programs.nixvim = {
    enable = true;
  };

  # direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = "lizelit";
    userEmail = "takku.hana@icloud.com";
  };

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -la";
      vim = "nvim";
      rebuild = "darwin-rebuild switch --flake ~/dotfiles";
    };
    
    initExtra = ''
      export EDITOR=nvim
    '';
  };

  programs.home-manager.enable = true;
}
