{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";

      extraEnv = {
        HOMEBREW_NO_ENV_HINTS = "1";
        HOMEBREW_NO_ANALYTICS = "1";
      };
    };
    taps = [
      {
        name = "laishulu/homebrew";
        trusted = true;
      }
      {
        name = "neurosnap/tap";
        trusted = true;
      }
      {
        name = "TheBoredTeam/boring-notch";
        trusted = true;
      }
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
      "steam"
      "microsoft-powerpoint"
      "microsoft-excel"
      "microsoft-word"
      "notion"
      "obsidian"
      "zed"
      "google-chrome"
      "visual-studio-code"
      "orbstack"
      "sf-symbols"
      "omniwm"
      # "android-studio"
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
