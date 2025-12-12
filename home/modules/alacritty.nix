{ ... }:

{
  programs.alacritty = {
    enable = true;
    
    settings = {
      window = {
        padding = { x = 10; y = 4; };
        dynamic_padding = true;
        opacity = 1.0;
        blur = true;
        decorations = "Buttonless";
        option_as_alt = "Both";
      };

      font = {
        size = 14.0;
        normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
      };

      mouse = {
        hide_when_typing = true;
      };

      colors = {
        primary = {
          foreground = "#dcd7ba";
          background = "#1f1f28";
        };

        cursor = {
          text = "#1f1f28";
          cursor = "#dcd7ba";
        };

        selection = {
          text = "#c8c093";
          background = "#2d4f67";
        };

        normal = {
          black = "#16161d";
          red = "#c34043";
          green = "#76946a";
          yellow = "#c0a36e";
          blue = "#7e9cd8";
          magenta = "#957fb8";
          cyan = "#6a9589";
          white = "#c8c093";
        };

        bright = {
          black = "#727169";
          red = "#e82424";
          green = "#98bb6c";
          yellow = "#e6c384";
          blue = "#7fb4ca";
          magenta = "#938aa9";
          cyan = "#7aa89f";
          white = "#dcd7ba";
        };
      };
    };
  };
}
