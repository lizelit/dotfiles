{ ... }:

{
  programs.nixvim.plugins = {
    lsp.enable = true;
    cmp.enable = true;
    treesitter.enable = true;
    none-ls.enable = true;
    trouble.enable = true;
  };
}
