{ ... }:

{
  programs.aerospace = {
    enable = true;
    launchd.enable = true;
    settings = {
      on-focus-changed = [
        "move-mouse window-lazy-center"
        "exec-and-forget macism com.apple.keylayout.ABC"
      ];

      on-focused-monitor-changed = [
        "move-mouse window-lazy-center"
      ];

      mode.main.binding = {
        "cmd-ctrl-t" = "exec-and-forget open -a /Applications/Alacritty.app";
        "cmd-ctrl-b" = "exec-and-forget open -a /Applications/Zen.app";

        "alt-h" = "focus left";
        "alt-j" = "focus down";
        "alt-k" = "focus up";
        "alt-l" = "focus right";

        "alt-ctrl-h" = "focus-monitor left";
        "alt-ctrl-l" = "focus-monitor right";

        "alt-shift-h" = "move left";
        "alt-shift-j" = "move down";
        "alt-shift-k" = "move up";
        "alt-shift-l" = "move right";

        "alt-1" = "workspace 1";
        "alt-2" = "workspace 2";
        "alt-3" = "workspace 3";
        "alt-4" = "workspace 4";
        "alt-5" = "workspace 5";
      };

      on-window-detected = [
        {
          "if" = { app-id = "io.zen-browser.zen"; };
          run = "move-node-to-workspace 1";
        }
        {
          "if" = { app-id = "org.alacritty"; };
          run = "move-node-to-workspace 1";
        }
        {
          "if" = { app-id = "com.apple.mail"; };
          run = "layout floating";
        }
        {
          "if" = { app-id = "com.apple.systempreferences"; };
          run = "layout floating";
        }
      ];
    };
  };
}
