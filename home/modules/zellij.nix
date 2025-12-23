{ ... }:

{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      pane_frames = false;
      # theme = "kanagawa";
      copy_on_select = true;
      scrollback_editor = "hx";
      session_serialization = false;
      pane_viewport_serialization = false;
      simplified_ui = true;
      show_startup_tips = false;
      copy_command = "pbcopy";
      paste_command = "pbpaste";
      system_clipboard = true;
      default_layout = "dev";
      macos-option-as-alt = "both";
      support_kitty_keyboard_protocol = false;

      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
    };

    layouts = {
      dev = {
        layout = {
          _children = [
            {
              pane = {
                size = 1;
                borderless = true;
                plugin = {
                  location = "zellij:compact-bar";
                };
              };
            }
            { pane = {}; }
          ];
        };
      };
    };
  };
}
