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
        keymap.preset = "enter";
        sources.default = [ "lsp" "path" "buffer" "snippets" ];
      };
    };
  };
}
