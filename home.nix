{
  config,
  lib,
  pkgs,
  username,
  homeDirectory,
  ...
}: {
  home.username = lib.mkForce username;
  home.homeDirectory = lib.mkForce homeDirectory;
  home.stateVersion = "24.05";

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
    fastfetch
    yazi
    lazygit

    python3
    black
    isort
    ruff

    typst
    tinymist

    ghc
    stack
    haskell-language-server
    fourmolu

    nodejs
    nodePackages.typescript
    nodePackages.prettier
    nodePackages.eslint

    rustc
    cargo
    rust-analyzer
    rustfmt

    elan

    texlive.combined.scheme-full

    lua-language-server
    stylua
    alejandra

    zellij
  ];

  programs.alacritty = {
    enable = true;
  };

  programs.helix = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "lizelit";
    userEmail = "lizelit.you@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = ["history" "completion"];
    syntaxHighlighting.enable = true;

    initContent = ''
      zel() {
        if [ -z "$1" ]; then
          echo "Usage: zel <directory>"
          return 1
        fi

        local dir="$1"
        if [ ! -d "$dir" ]; then
          echo "Error: '$dir' is not a directory"
          return 1
        fi

        local session
        session=$(basename "$(realpath "$dir")")

        cd "$dir" || return

        if zellij list-sessions | grep -q "^$session$"; then
          zellij attach "$session"
        else
          zellij attach --create "$session"
        fi
      }
      EDITOR=hx
    '';

    shellAliases = {
      ll = "eza -la";
      la = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      grep = "rg";

      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";

      nr = "nix run";
      ns = "nix shell";
      nf = "nix flake";

      dr = "sudo darwin-rebuild switch --flake ~/dotfiles";
      hm = "home-manager switch --flake ~/dotfiles";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf" "docker"];
      theme = "robbyrussell";
    };
  };

  xdg = {
    enable = true;
    configFile."alacritty/alacritty.toml".source = ./config/alacritty.toml;
    configFile."zellij/config.kdl".source = ./config/zellij.kdl;
    configFile."zellij/layouts".source = ./config/layouts;
    configFile."starship.toml".source = ./config/starship.toml;
    configFile."helix/config.toml".source = ./config/helix/config.toml;
    configFile."helix/languages.toml".source = ./config/helix/languages.toml;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox";
    };
    themes = {
      gruvbox = ''
        theme[main_bg]="#282828"
        theme[main_fg]="#d4be98"
        theme[title]="#d4be98"
        theme[hi_fg]="#ea6962"
        theme[selected_bg]="#d8a657"
        theme[selected_fg]="#282828"
        theme[inactive_fg]="#282828"
        theme[graph_text]="#665c54"
        theme[proc_misc]="#a9b665"
        theme[cpu_box]="#7c6f64"
        theme[mem_box]="#7c6f64"
        theme[net_box]="#7c6f64"
        theme[proc_box]="#7c6f64"
        theme[div_line]="#7c6f64"
        theme[temp_start]="#7daea3"
        theme[temp_mid]="#e78a4e"
        theme[temp_end]="#ea6962"
        theme[cpu_start]="#a9b665"
        theme[cpu_mid]="#d8a657"
        theme[cpu_end]="#ea6962"
        theme[free_start]="#89b482"
        theme[free_mid]=""
        theme[free_end]=""
        theme[cached_start]="#7daea3"
        theme[cached_mid]=""
        theme[cached_end]=""
        theme[available_start]="#d8a657"
        theme[available_mid]=""
        theme[available_end]=""
        theme[used_start]="#ea6962"
        theme[used_mid]=""
        theme[used_end]=""
        theme[download_start]="#e78a4e"
        theme[download_mid]=""
        theme[download_end]=""
        theme[upload_start]="#d3869b"
        theme[upload_mid]=""
        theme[upload_end]=""
      '';
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
