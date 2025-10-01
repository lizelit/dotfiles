{ config, pkgs, inputs, username ? "lizelit", homeDirectory ? "/Users/lizelit", ... }:

{
  # Home Manager basic configuration
  home = {
    inherit username homeDirectory;
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "Safari";
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
      
      # Other tools
      ffmpeg
      imagemagick
      pandoc

      pkgs.nerd-fonts.jetbrains-mono
    ];
  };

  programs.nixvim = {
    enable = true;
    
    # 💡 基本的なエディタオプション
    options = {
      relativenumber = true;
      number = true;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      # 行折り返しをオフ
      wrap = false; 
    };

    # 🌈 カラースキームと見た目
    colorScheme = "catppuccin";
    colorschemes = {
      catppuccin = {
        enable = true;
        settings.flavour = "mocha";
      };
    };

    # 🌟 LazyVim風のモダンな機能の有効化
    plugins = {
      # 起動高速化のためのプラグインローダー
      lazy.enable = true;
      
      # LSPクライアントの有効化
      lsp.enable = true;
      
      # 補完エンジン
      cmp.enable = true;
      
      # 構文解析とハイライト
      treesitter = {
        enable = true;
        settings.ensure_installed = [ 
          "lua" "nix" "javascript" "typescript" "html" "css"
        ];
      };

      # ファイル・バッファ・Gitなどのファジーファインダー
      telescope.enable = true;
      
      # ファイルツリー
      neo-tree.enable = true;
      
      # Git連携 (行単位の変更表示など)
      gitsigns.enable = true;
      
      # ステータスライン
      lualine.enable = true;
      
      # 言語サーバーのインストール (mason.nvimの代わり)
      # 必要な言語サーバーをここで定義すれば、Nixがインストールしてくれます。
      mason = {
        enable = true;
        # 例: TypeScript/JavaScriptとNixのLSPをインストール
        ensureInstalled = [
          "typescript-language-server"
          "nil" # Nix Language Server
        ];
      };

    };
  };

  programs.wezterm = {
    enable = true;
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
    configFile."wezterm/wezterm.lua".source = ./config/wezterm.lua;
  };
}
