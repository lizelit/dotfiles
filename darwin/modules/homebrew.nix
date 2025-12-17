{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = [
    ];

    casks = [
      "karabiner-elements"
      "utm"
      "spotify"
      "alacritty"
      "font-jetbrains-mono-nerd-font"
      "visual-studio-code"
      "zed"
      "balenaetcher"
      "hhkb"
      "zen"
      "skim"
      "zoom"
      "google-chrome"
      "monitorcontrol"
      "notchnook"
      "steam"
      "microsoft-powerpoint"
      "microsoft-excel"
      "microsoft-word"
    ];

    brews = [
      "macism"
    ];

    masApps = {
      # "Xcode" = 497799835;
      "Amphetamine" = 937984704;
      "AdGuard for Safari" = 1440147259;
      "RunCat" = 1429033973;
      "CleanMyKeyboard" = 6468120888;
      "Amazon Prime Video" = 545519333;
    };
  };
}
