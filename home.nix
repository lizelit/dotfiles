{ config, lib, pkgs, username, homeDirectory, ... }:
{
  home.username = lib.mkForce username;
  home.homeDirectory = lib.mkForce homeDirectory;
  home.stateVersion = "24.05";

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
    fzf
    bat
    eza
  ];

  # NixVim設定
  programs.nixvim = {
	  enable = true;

	  options = {
		  number = true;
		  relativenumber = true;
		  tabstop = 2;
		  shiftwidth = 2;
		  expandtab = true;
	  };


	  plugins = {
		  lualine.enable = true;
		  telescope.enable = true;
		  treesitter.enable = true;
	  };
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
      ll = "eza -la";
      vim = "nvim";
      cat = "bat";
      rebuild = "darwin-rebuild switch --flake ~/dotfiles";
    };
    
    initContent = ''
      export EDITOR=nvim
      export VISUAL=nvim
    '';
  };

  programs.home-manager.enable = true;
}
