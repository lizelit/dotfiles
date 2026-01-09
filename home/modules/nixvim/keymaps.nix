{ ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      { mode = "n"; key = "gh"; action = "0"; }
      { mode = "n"; key = "gl"; action = "$"; }
      { mode = "n"; key = "ge"; action = "G"; }
      { mode = "n"; key = "gg"; action = "gg"; }
      {
        mode = "n";
        key = "gw";
        action = ''
          lua require("flash").jump({
            search = { mode = "search", max_length = 2 },
            label = { after = { 0, 0 } },
            pattern = [[\<\w]]
          })
        '';
        options.desc = "Go to Word";
      }

      { mode = "n"; key = "<leader>f"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Files"; }
      { mode = "n"; key = "<leader>/"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Grep"; }
      { mode = "n"; key = "<leader>b"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Buffers"; }
      { mode = "n"; key = "<leader>e"; action = "<cmd>lua require('oil').toggle_float()<CR>"; options.desc = "Explorer"; }
      { mode = "n"; key = "<leader>d"; action = "<cmd>Trouble diagnostics toggle<CR>"; options.desc = "Explorer"; }
      { mode = "n"; key = "<leader>t"; action = "<cmd>ToggleTerm<CR>"; options.desc = "Terminal"; }
      { mode = "n"; key = "<leader>g"; action = "<cmd>LazyGit<CR>"; options.desc = "LazyGit"; }
    ];
  };
}
