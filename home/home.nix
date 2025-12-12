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
    ripgrep fd tree fzf bat btop delta eza fastfetch yazi lazygit zellij
    rustc cargo rust-analyzer rustfmt clippy
    ghc stack haskell-language-server fourmolu
    (python3.withPackages (ps: with ps; [
      numpy
    ]))
    pyright black isort ruff
    lldb
  ];


  programs.spotify-player = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
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
    settings.user.name = "lizelit";
    settings.user.email = "lizelit.you@gmail.com";
  };
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = ["history" "completion"];
    syntaxHighlighting.enable = true;
    shellAliases = {
      e = "$EDITOR";
      ls = "eza";
      la = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      grep = "rg";

      spp = "spotify_player";

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
      ss = "scheme --script";
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
    initContent = ''
        if [ -z "$ZELLIJ_PANE_ID" ]; then
          zellij attach dev 2>/dev/null || zellij --session dev
        fi
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';
  };

  xdg = {
    enable = true;
    configFile."alacritty/alacritty.toml".source = ./config/alacritty/config.toml;
    configFile."zellij/config.kdl".source = ./config/zellij.kdl;
    configFile."zellij/layouts/default.kdl".source = ./config/layouts.kdl;
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
