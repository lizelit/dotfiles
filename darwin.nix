{
  config,
  pkgs,
  inputs,
  username,
  hostname,
  homeDirectory,
  ...
}: {
  # Nix build user group ID configuration
  ids.gids.nixbld = 350;

  # Primary user configuration (required for homebrew and system defaults)
  system.primaryUser = username;

  # Nix configuration
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = ["${username}" "root" "@admin"];
    };

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

  # System packages
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      window_shadow = false;
      window_topmost = true;
      window_gap = 8;
      top_padding = 8;
      bottom_padding = 8;
      left_padding = 8;
      right_padding = 8;
      layout = "bsp";
    };
    extraConfig = ''
      yabai -m config focus_follows_mouse autoraise
      yabai -m config mouse_follows_focus on
      yabai -m rule --add app="Finder" manage=off
      yabai -m rule --add app="System Settings" manage=off
      yabai -m rule --add app="Spotify" manage=off
      yabai -m rule --add app="Discord" manage=off
      yabai -m rule --add app="Slack" manage=off
      yabai -m rule --add app="Mail" manage=off
    '';
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      ctrl - return : open -a "Alacritty"
      ctrl + alt - return : open -a "orion"
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east
      alt - p : yabai -m display --focus prev
      alt - n : yabai -m display --focus next
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east
    '';
  };

  # Homebrew configuration
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    taps = [
      "laishulu/homebrew"
    ];

    # GUI applications
    casks = [
      "karabiner-elements"
      "discord"
      "slack"
      "spotify"
      "wezterm"
      "alacritty"
      "font-jetbrains-mono-nerd-font"
      "visual-studio-code"
      "obsidian"
      "balenaetcher"
      "google-chrome"
      "hhkb"
      "orion"
    ];

    # CLI tools that aren't available in Nix
    brews = [
      # Add tools here as needed
      "macism"
    ];

    # Mac App Store apps
    masApps = {
      "Xcode" = 497799835;
      "Amphetamine" = 937984704;
      "AdGuard for Safari" = 1440147259;
      "RunCat" = 1429033973;
      "CleanMyKeyboard" = 6468120888;
    };
  };

  # System defaults
  system = {
    stateVersion = 4;

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        orientation = "bottom";
        tilesize = 48;
        minimize-to-application = true;
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      NSGlobalDomain = {
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };

      screencapture = {
        location = "~/Screenshots";
        type = "png";
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  # Nixpkgs configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    hostPlatform = "aarch64-darwin";
  };

  # Programs
  programs = {
    zsh.enable = true;
  };
}
