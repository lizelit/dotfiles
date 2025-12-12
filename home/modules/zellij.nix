{ ... }:

{
  programs.zellij = {
    enable = true;
    
    settings = {
      pane_frames = false;
      theme = "kanagawa";
      copy_on_select = true;
      scrollback_editor = "hx";
      session_serialization = false;
      pane_viewport_serialization = false;
      simplified_ui = true;
      show_startup_tips = false;
      copy_command = "pbcopy";
      paste_command = "pbpaste";
      system_clipboard = true;
      default_layout = "default";
      
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
      
      prelude = {
        default = ''
          layout {
            pane size=1 borderless=true {
              plugin location="zellij:compact-bar"
            }
            pane
          }
        '';
      };
    };
  };
}
