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
      "spotify"
      "alacritty"
      "font-jetbrains-mono-nerd-font"
      "zed"
      "balenaetcher"
      "hhkb"
      "zen"
      "skim"
      "zoom"
      "monitorcontrol"
      "notchnook"
      "steam"
      "microsoft-powerpoint"
      "microsoft-excel"
      "microsoft-word"
      "jordanbaird-ice"
    ];

    brews = [
      "macism"
    ];

    masApps = {
      # "Xcode" = 497799835;
      "Amphetamine" = 937984704;
      "RunCat" = 1429033973;
      "CleanMyKeyboard" = 6468120888;
      "Amazon Prime Video" = 545519333;
    };
  };
}
