{ config, pkgs, inputs, username, hostname, homeDirectory, ... }:

{
  # Nix build user group IDの修正
  ids.gids.nixbld = 350;

  # Nix設定
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "${username}" "root" "@admin" ];
    };
    
    # auto-optimise-store の代わりに optimise.automatic を使用
    optimise = {
      automatic = true;
    };
    
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  # プライマリユーザーの設定（必須）
  system.primaryUser = username;

  # 最小限のシステムパッケージ
  environment.systemPackages = with pkgs; [
    # 基本的なツールのみ
    git
  ];

  # Homebrew設定
  homebrew = {
    enable = true;
    
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };

    # ここに必要なアプリを追加
    casks = [
      # 例: 基本的なアプリ
      # "google-chrome"
      # "visual-studio-code" 
      "darwin"
    ];

    brews = [
      # 例: Nixで管理できないCLIツール
    ];

    masApps = {
      # 例: Mac App Store アプリ
      # "Xcode" = 497799835;
    };
  };

  # システム設定
  system = {
    stateVersion = 4;
    
    # 基本的なmacOS設定
    defaults = {
      dock = {
        autohide = true;
      };
      
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
      };
      
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
      };
    };
  };

  # Nixpkgs設定
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    
    # neovim-nightly-overlayを適用
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];
    
    hostPlatform = "x86_64-darwin"; # Intel Mac用
  };

  # Services (nix-daemon設定を削除)
  services = {
    # nix-daemon.enable は不要になったため削除
  };

  # セキュリティ設定
  security.pam.services.sudo_local.touchIdAuth = true;

  # プログラム設定
  programs = {
    zsh.enable = true;
  };
}
