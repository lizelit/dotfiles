{ ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      { mode = ["n" "v"]; key = "gh"; action = "0"; }
      { mode = ["n" "v"]; key = "gl"; action = "$"; }
      { mode = ["n" "v"]; key = "ge"; action = "G"; }
      { mode = ["n" "v"]; key = "gg"; action = "gg"; }
      {
        mode = "n";
        key = "gw";
        action = "<cmd>lua require('flash').jump()<CR>";
        options.desc = "Go to Word";
      }

      { mode = ["n" "v"]; key = "<leader>y"; action = "\"+y"; options.desc = "Yank to system clipboard."; }
      { mode = ["n" "v"]; key = "<leader>p"; action = "\"+p"; options.desc = "Paste from system clipboard"; }

      { mode = "n"; key = "<leader>f"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Files"; }
      { mode = "n"; key = "<leader>/"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Grep"; }
      { mode = "n"; key = "<leader>b"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Buffers"; }
      { mode = "n"; key = "<leader>e"; action = "<cmd>lua require('oil').toggle_float()<CR>"; options.desc = "Explorer"; }
      # { mode = "n"; key = "<leader>d"; action = "<cmd>Trouble diagnostics toggle<CR>"; options.desc = "Diagnostics"; }
      { mode = "n"; key = "<leader>t"; action = "<cmd>ToggleTerm<CR>"; options.desc = "Terminal"; }
      { mode = "n"; key = "<leader>g"; action = "<cmd>LazyGit<CR>"; options.desc = "LazyGit"; }

      { mode = "n"; key = "<C-c>"; action = "<cmd> lua require('Comment.api').toggle.linewise.current()<CR>"; options.desc = "Comment"; }
    ];
  };
}
