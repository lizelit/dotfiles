{ pkgs, inputs, ... }:

let
  nvim-spotify = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-spotify";
      version = inputs.nvim-spotify.shortRev or "dev";
      src = inputs.nvim-spotify;
    };
in
{
  # programs.nixvim.extraPlugins = [ nvim-spotify ];
  # programs.nixvim.extraConfigLua = ''
  #   require("spotify").setup({
  #       client_id = "69e60a9265a949a7bcb45c94f2d7bc72",
  #     })
  # '';
  programs.nixvim.plugins = {
    noice.enable = true;
    oil.enable = true;
    flash.enable = true;
    multicursors.enable = true;
    render-markdown.enable = true;
    treesj.enable = true;
    lualine.enable = true;
    tiny-inline-diagnostic.enable = true;
    modicator.enable = true;
    fidget.enable = true;
    neotab = {
        enable = true;
        settings = {
            tabkey = "<Tab>";
            reverse_key = "<S-Tab>";
            act_as_tab = true;
            behavior = "nested";
        };
    };
    vimtex = {
      enable = true;
      texlivePackage = pkgs.texliveFull;
      settings = {
        compiler_method = "latexmk";
        view_method = "skim";

        view_skim_sync = true;
        view_skim_activate = true;
      };
    };

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

          window.delay = 100;
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
        align = {};
        jump = {};
        hipatterns = {
          highlighters = {
            fixme = {
              pattern = "%f[%w]()FIXME()%f[%W]";
              group = "MiniHipatternsFixme";
            };
            hack = {
              pattern = "%f[%w]()HACK()%f[%W]";
              group = "MiniHipatternsHack";
            };
            todo = {
              pattern = "%f[%w]()TODO()%f[%W]";
              group = "MiniHipatternsTodo";
            };
            note = {
              pattern = "%f[%w]()NOTE()%f[%W]";
              group = "MiniHipatternsNote";
            };
          };
        };
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
        image.enabled = true;
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
