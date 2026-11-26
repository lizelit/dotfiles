{ ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      {
        mode = "n";
        key = "gw";
        action = "<cmd>lua require('flash').jump()<CR>";
        options.desc = "Flash jump";
      }
      {
        mode = "n";
        key = "<Esc><Esc>";
        action = "<cmd>nohlsearch<CR>";
        options.desc = "Clear search highlight";
      }

      {
        mode = ["n" "v"];
        key = "<leader>y";
        action = "\"+y";
        options.desc = "Yank to system clipboard.";
      }
      {
        mode = ["n" "v"];
        key = "<leader>p";
        action = "\"+p";
        options.desc = "Paste from system clipboard";
      }

      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>lua Snacks.picker.files()<CR>";
        options.desc = "Files";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>lua Snacks.picker.grep()<CR>";
        options.desc = "Grep";
      }
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
        options.desc = "Buffer list";
      }
      {
        mode = "n";
        key = "<leader>bn";
        action = "<cmd>bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>bprev<CR>";
        options.desc = "Prev buffer";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua require('oil').toggle_float()<CR>";
        options.desc = "Explorer";
      }
      {
        mode = "n";
        key = "<leader>t";
        action = "<cmd>lua Snacks.terminal.toggle()<CR>";
        options.desc = "Terminal";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>lua Snacks.lazygit()<CR>";
        options.desc = "LazyGit";
      }

      {
        mode = "n";
        key = "<leader>rj";
        action = "<cmd>RocqNext<CR>";
        options.desc = "Rocq: Next";
      }
      {
        mode = "n";
        key = "<leader>rk";
        action = "<cmd>RocqUndo<CR>";
        options.desc = "Rocq: Undo";
      }
      {
        mode = "n";
        key = "<leader>rl";
        action = "<cmd>RocqToLine<CR>";
        options.desc = "Rocq:ToLine";
      }
      {
        mode = "n";
        key = "<leader>rg";
        action = "<cmd>RocqStart<CR>";
        options.desc = "Rocq: Start";
      }

      {
        mode = "n";
        key = "<leader>uz";
        action = "<cmd>lua Snacks.zen()<CR>";
        options.desc = "Toggle Zen Mode";
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>gb";
        action = "<cmd>lua Snacks.gitbrowse()<CR>";
        options.desc = "Git Browse";
      }
    ];
  };
}
