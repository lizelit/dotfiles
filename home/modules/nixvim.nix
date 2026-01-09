{ ... }:

{
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
    };

    globals.mapleader = " ";

    colorschemes.kanagawa = {
      enable = true;
    };

    plugins = {
      lsp.enable = true;
      cmp.enable = true;
      treesitter.enable = true;

      mini-icons.enable = true;
      telescope.enable = true;
      trouble.enable = true;

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
