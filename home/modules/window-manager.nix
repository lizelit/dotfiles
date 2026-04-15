{ ... }:

{
  # programs.sketchybar.enable = false;
  services.jankyborders = {
    enable = false;
    settings = {
      style="round";
        width=8.0;
        hidpi="off";
        active_color="0xffe2e2e3";
        inactive_color="0xff414550";
    };
  };
  programs.aerospace = {
    enable = false;
    launchd.enable = true;
    settings = {
      gaps = {
        inner = {
          horizontal = 14;
          vertical = 14;
        };
        outer = {
          left = 14;
          right = 14;
          top = 14;
          bottom = 14;
        };
      };
      on-focus-changed = [
        "move-mouse window-lazy-center"
        "exec-and-forget macism com.apple.keylayout.ABC"
      ];

      after-startup-command = ["exec-and-forget sketchybar"];

      on-focused-monitor-changed = [
        "move-mouse window-lazy-center"
      ];
      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$(aerospace workspace)"
      ];
        mode.main.binding = {
        "cmd-ctrl-t" = "exec-and-forget open -a Ghostty";
        "cmd-ctrl-b" = "exec-and-forget open -a Zen";
        "cmd-ctrl-e" = "exec-and-forget open -a Zed";

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
        "alt-tab" = "workspace-back-and-forth";
        "alt-r" = " mode resize";
      };

      mode.resize.binding = {
        "h" = "resize width -50";
        "j" = "resize height +50";
        "k" = "resize height -50";
        "l" = "resize width +50";
        "enter" = "mode main";
        "esc" = "mode main";
      };

      on-window-detected = [
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
        {
          "if" = { app-id = "com.apple.Notes"; };
          run = "layout floating";
        }
        {
          "if" = { app-id = "com.apple.finder"; };
          run = "layout floating";
        }
      ];
    };
  };
}
