{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
      extraFlags = ["--force"];
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
      "BarutSRB/tap/omniwm"
      # "hammerspoon"
      "android-studio"
      # "aquaskk"
      "macskk"
      "flutter"
    ];

    brews = [
      "macism"
      "neurosnap/tap/zmx"
      "cocoapods"
    ];

    masApps = {
      "Xcode" = 497799835;
      "RunCat" = 1429033973;
      "CleanMyKeyboard" = 6468120888;
    };
  };
}
