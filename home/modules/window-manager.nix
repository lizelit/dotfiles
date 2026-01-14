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

        "alt-shift-f" = "fullscreen";

        "alt-1" = "workspace 1";
        "alt-2" = "workspace 2";
        "alt-3" = "workspace 3";
        "alt-4" = "workspace 4";
        "alt-5" = "workspace 5";
        "alt-6" = "workspace 6";
        "alt-7" = "workspace 7";
        "alt-8" = "workspace 8";
        "alt-9" = "workspace 9";
        "alt-0" = "workspace 10";

        "alt-shift-1" = "move-node-to-workspace 1";
        "alt-shift-2" = "move-node-to-workspace 2";
        "alt-shift-3" = "move-node-to-workspace 3";
        "alt-shift-4" = "move-node-to-workspace 4";
        "alt-shift-5" = "move-node-to-workspace 5";
        "alt-shift-6" = "move-node-to-workspace 6";
        "alt-shift-7" = "move-node-to-workspace 7";
        "alt-shift-8" = "move-node-to-workspace 8";
        "alt-shift-9" = "move-node-to-workspace 9";
        "alt-shift-0" = "move-node-to-workspace 10";

        "alt-r" = " mode resize";
      };

      mode.resize.binding = {
        "h" = "resize width -50";
        "j" = "resize width +50";
        "k" = "resize width -50";
        "l" = "resize width +50";
        "enter" = "mode main";
        "esc" = "mode main";
      };

      on-window-detected = [
        # {
        #   "if" = { app-id = "app.zen-browser.zen"; };
        #   run = "move-node-to-workspace 1";
        # }
        # {
        #   "if" = { app-id = "org.alacritty"; };
        #   run = "move-node-to-workspace 1";
        # }
        {
          "if" = { app-id = "com.apple.mail"; };
          run = "layout floating";
        }
        {
          "if" = { app-id = "com.spotify.client"; };
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
