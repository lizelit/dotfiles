{pkgs, config, ... }:

{
  programs.nixvim = {
    plugins.lspconfig.enable = true;
    lsp = {
      servers.texlab.enable = true;
      servers.rust_analyzer.enable = true;
      servers.nixd.enable = true;
      servers.clangd.enable = true;
    };
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "default";
        sources.default = [ "lsp" "path" "buffer" "snippets" ];
        sources.per_filetype = {
          tex = ["lsp" "path" "snippets" ];
          typst = ["lsp" "path" "snippets" ];
        };
      };
    };
    plugins.treesitter = {
      enable = true;

      grammarPackages =
        with config.programs.nixvim.plugins.treesitter.package.builtGrammars;
        [
          bash
          json
          lua
          markdown
          nix
          rust
          toml
          vim
          vimdoc
          yaml
        ];

      highlight.enable = true;

    };
  };
}
