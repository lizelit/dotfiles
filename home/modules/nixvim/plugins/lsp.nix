{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    lsp.enable = true;
    cmp.enable = true;
    treesitter.enable = true;
    none-ls.enable = true;
    trouble.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
    cmp-buffer.enable = true;

    lsp = {
      diagnostics = {
        virtual_text = false;
        virtual_lines = {
          only_current_line = false;
        };
        underline = true;
        signs = true;
      };

      keymaps = {
        diagnostic = {
          "<leader>d" = {
            action = "open_float";
          };
        };
      };

      servers = {
        nixd.enable = true;
        rust_analyzer = {
          enable = true;
          settings = {
            inlayHints = {
              bindingModeHints.enable = true;
              chainingHints.enable = true;
              closingBraceHints.enable = true;
              parameterHints.enable = true;
              typeHints.enable = true;
            };
          };
          onAttach.function = "vim.lsp.inlay_hint.enable(true)";
        };
      };
    };

    cmp = {
      settings = {
        autoEnableSources = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<S-tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        };
      };
    };

    none-ls = {
      sources.formatting = {
        nixpkgs_fmt.enable = true;
      };
    };

    extraPackages = with pkgs; [
      nix
      nixpkgs-fmt
    ];
  };
}
