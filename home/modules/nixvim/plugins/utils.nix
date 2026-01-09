{ ... }:

{
  programs.nixvim.plugins = {
    oil.enable = true;
    telescope.enable = true;
    flash.enable = true;
    multicursors.enable = true;
    nvim-surround.enable = true;
    nvim-autopairs.enable = true;
    comment.enable = true;
    gitsigns.enable = true;

    oil.settings = {
      view_options = {
        show_hidden = true;
      };
    };
  };
}
