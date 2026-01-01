{ config, pkgs, ... }:

{
  environment.shells = [ pkgs.fish ];

  users.users."${config.system.primaryUser}" = {
    shell = pkgs.fish;
  };

  environment.pathsToLink = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  ids.gids.nixbld = 350;

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 4;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

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
        location = "~/Pictures/Screenshots";
        type = "png";
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          NSTextInsertionPointBlinkPeriodOn = 0;
          NSTextInsertionPointBlinkPeriodOff = 0;
        };
        "com.apple.WindowManager" = {
          AppWindowFocusHover = 1;
        };
      };
    };
  };

  programs.fish.enable = true;
}
