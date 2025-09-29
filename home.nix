{ config, pkgs, inputs, username ? "lizelit", homeDirectory ? "/Users/lizelit", ... }:

{
  # Home Manager basic configuration
  home = {
    inherit username homeDirectory;
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "safari";
      TERMINAL = "wezterm";
    };

    packages = with pkgs; [
      # CLI tools
      bat              # cat alternative
      eza              # ls alternative
      fd               # find alternative
      fzf              # fuzzy finder
      ripgrep          # grep alternative
      jq               # JSON processor
      yq               # YAML processor
      tree             # directory tree
      htop             # process monitor
      
      # Development tools
      lazygit
      gh               # GitHub CLI
      
      # Language servers
      nil              # Nix LSP
      rust-analyzer
      nodePackages.typescript-language-server

      mas
      kitty
      
      # Other tools
      ffmpeg
      imagemagick
      pandoc

      pkgs.nerd-fonts.jetbrains-mono
    ];
  };

  # Neovim Nightly with basic plugins
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      nodejs
      git
    ];
  };

  programs.wezterm = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    font.name = "JetBrains Mono";
    font.size = 14;
    themeFile = "Everforest_Dark_Medium";
  };


  # Zsh with Oh My Zsh and useful plugins
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      # Basic aliases
      ll = "eza -la";
      la = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      grep = "rg";
      
      # Git aliases
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      
      # Nix aliases
      nr = "nix run";
      ns = "nix shell";
      nf = "nix flake";
      
      # Darwin aliases
      dr = "sudo darwin-rebuild switch --flake ~/dotfiles";
      hm = "home-manager switch --flake ~/dotfiles";
    };
    
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "docker" ];
      theme = "robbyrussell";
    };
  };

  # Direnv for automatic environment switching
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Fzf fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--inline-info"
    ];
  };

  # XDG directories
  xdg = {
    enable = true;
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    cacheHome = "${homeDirectory}/.cache";
    configFile."nvim".source = ./nvim;
    configFile."wezterm/wezterm.lua".source = ./config/wezterm.lua;
  };
}
