{ ... }:

{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];
  programs.nixvim = {
    enable = true;

    colorschemes.kanagawa = {
      enable = true;
    };


    plugins = {
      lsp.enable = true;
      cmp.enable = true;
      treesitter.enable = true;
      multicursors.enable = true;
      noice.enable = true;

      telescope.enable = true;
      oil.enable = true;
      trouble.enable = true;
      none-ls.enable = true;
      bufferline.enable = true;

      comment.enable = true;
      nvim-surround.enable = true;
      nvim-autopairs.enable = true;
      lualine.enable = true;
      indent-blankline.enable = true;
      gitsigns.enable = true;
      flash.enable = true;
      which-key.enable = true;
    };
  };
}
