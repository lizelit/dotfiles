{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    lsp.enable = true;
    cmp.enable = true;
    treesitter.enable = true;
    none-ls.enable = true;
    trouble.enable = true;

    lsp = {
      servers = {
        nixd.enable = true;
        rust_analyzer.enable = true;
      };
    };

    none-ls = {
      sources.formatting = {
        nixpkgs_fmt.enable = true;
      };
    };

    extraPackages = with pkgs; [
      nixd
      nixpkgs-fmt
    ];
  };
}
