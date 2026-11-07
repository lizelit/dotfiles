{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
      extraFlags = ["--force"];
    };
    taps = [
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
      # "notchnook"
      "steam"
      "microsoft-powerpoint"
      "microsoft-excel"
      "microsoft-word"
      "notion"
      "obsidian"
      "zed"
      # "antigravity"
      "google-chrome"
      "visual-studio-code"
      "orbstack"
      "sf-symbols"
      "BarutSRB/tap/omniwm"
      # "android-studio"
      # "macskk"
      "aquaskk"
      # "flutter"
      "zotero"
      "TheBoredTeam/boring-notch/boring-notch"
      "discord"
      "orion"
    ];

    brews = [
      "macism"
      "neurosnap/tap/zmx"
      "cocoapods"
    ];

    masApps = {
      "Xcode" = 497799835;
      "RunCat Neo" = 6757801838;
      "CleanMyKeyboard" = 6468120888;
      "Amazon Prime Video" = 545519333;
      "Amazon Kindle" = 302584613;
    };
  };
}
