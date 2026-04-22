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
      "neurosnap/tap"
      # "glzr-io/tap"
      "BarutSRB/tap"
    ];

    casks = [
      "karabiner-elements"
      "spotify"
      "alacritty"
      "ghostty"
      "font-jetbrains-mono-nerd-font"
      "font-udev-gothic-nf"
      "font-noto-color-emoji"
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
      "notion"
      "obsidian"
      "zed"
      "antigravity"
      "google-chrome"
      "visual-studio-code"
      "orbstack"
      "sf-symbols"
      # "glzr-io/tap/glazewm"
      # "glzr-io/tap/zebar"
      "BarutSRB/tap/omniwm"
      "hammerspoon"
    ];

    brews = [
      "macism"
      "neurosnap/tap/zmx"
    ];

    masApps = {
      # "Xcode" = 497799835;
      "RunCat" = 1429033973;
      "CleanMyKeyboard" = 6468120888;
    };
  };
}
