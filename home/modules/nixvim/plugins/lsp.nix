{pkgs, ... }:

{
  programs.nixvim = {
    plugins.lspconfig.enable = true;
    lsp = {
      servers.texlab.enable = true;
    };
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "default";
        sources.default = [ "lsp" "path" "buffer" "snippets" ];
        sources.per_filetype = {
          tex = ["lsp" "path" "snippets" ];
        };
      };
    };
  };
}
