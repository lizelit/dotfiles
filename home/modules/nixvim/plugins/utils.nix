{ ... }:

{
  programs.nixvim.plugins = {
    oil.enable = true;
    flash.enable = true;
    multicursors.enable = true;

    mini = {
      enable = true;
      mockDevIcons = true;

      modules = {
        ai = {};

        clue = {
          triggers = [
            { mode = "n"; keys = "<Leader>"; }
            { mode = "x"; keys = "<Leader>"; }
            { mode = "n"; keys = "g"; }
            { mode = "n"; keys = "z"; }
            { mode = "n"; keys = "["; }
            { mode = "n"; keys = "]"; }
            { mode = "n"; keys = "<C-w>"; }
            { mode = ["n" "x"]; keys = "'"; }
            { mode = ["n" "x"]; keys = "`"; }
            { mode = ["n" "x"]; keys = "\""; }
            { mode = ["i" "c"]; keys = "<C-r>"; }
            { mode = "i"; keys = "<C-x>"; }
          ];

          window.delay = 300;
        };
        comment = {};
        git = {};
        diff = {};
        icons = {};
        surround = {};
        pairs = {};
        move = {};
        operators = {};
        bracketed = {};
        statusline = {};
        trailspace = {};
        starter = {};
      };
    };

    snacks = {
      enable = true;
      settings = {
        picker = {
          enabled = true;
          matcher = {
            smartcase = false;
            ignorecase = true;
          };
        };
        terminal.enabled = true;
        indent.enabled = true;
        notifier.enabled = true;
        input.enabled = true;
        scope.enabled = true;
        statuscolumn.enabled = true;
        bigfile.enabled = true;
        zen.enabled = true;
        gitbrowse.enabled = true;
        lazygit.enabled = true;
      };
    };
    oil.settings = {
      view_options = {
        show_hidden = true;
      };

      float = {
        max_width = 60;
        max_height = 50;
      };

      keymaps = {
        "<esc><esc>" = "actions.close";
      };
    };

  };
}
