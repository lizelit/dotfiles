{ ... }:

{
  programs.nixvim.plugins = {
    oil.enable = true;
    toggleterm.enable = true;
    telescope.enable = true;
    flash.enable = true;
    multicursors.enable = true;
    nvim-surround.enable = true;
    nvim-autopairs.enable = true;
    comment.enable = true;
    gitsigns.enable = true;
    lazygit.enable = true;

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

    toggleterm.settings = {
      direction = "float";
    };
  };
}
