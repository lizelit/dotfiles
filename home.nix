{ config, lib, pkgs, ... }:

{
  home.username = "lizelit";
  home.homeDirectory = lib.mkForce "/Users/lizelit";  # NixVimのnull設定を強制上書き
  home.stateVersion = "24.05";

  # 基本パッケージ
  home.packages = with pkgs; [
    ripgrep
    fd
    git
    gcc
    nodejs
    tree
    wget
    curl
  ];

  # NixVim設定
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # カラースキーム
    colorschemes.tokyonight = {
      enable = true;
      settings.style = "night";
    };

    # オプション
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
      signcolumn = "yes";
      cursorline = true;
      wrap = false;
      splitright = true;
      splitbelow = true;
      mouse = "a";
      clipboard = "unnamedplus";
      undofile = true;
      updatetime = 250;
      timeoutlen = 300;
      scrolloff = 8;
      sidescrolloff = 8;
    };

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    # キーマップ
    keymaps = [
      { mode = "n"; key = "j"; action = "v:count == 0 ? 'gj' : 'j'"; options = { expr = true; silent = true; }; }
      { mode = "n"; key = "k"; action = "v:count == 0 ? 'gk' : 'k'"; options = { expr = true; silent = true; }; }
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options = { desc = "Go to left window"; }; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options = { desc = "Go to lower window"; }; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options = { desc = "Go to upper window"; }; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options = { desc = "Go to right window"; }; }
      { mode = "n"; key = "<C-Up>"; action = ":resize +2<CR>"; }
      { mode = "n"; key = "<C-Down>"; action = ":resize -2<CR>"; }
      { mode = "n"; key = "<C-Left>"; action = ":vertical resize -2<CR>"; }
      { mode = "n"; key = "<C-Right>"; action = ":vertical resize +2<CR>"; }
      { mode = "n"; key = "<A-j>"; action = ":m .+1<CR>=="; }
      { mode = "n"; key = "<A-k>"; action = ":m .-2<CR>=="; }
      { mode = "v"; key = "<A-j>"; action = ":m '>+1<CR>gv=gv"; }
      { mode = "v"; key = "<A-k>"; action = ":m '<-2<CR>gv=gv"; }
      { mode = "n"; key = "<S-h>"; action = ":bprevious<CR>"; options = { desc = "Prev buffer"; }; }
      { mode = "n"; key = "<S-l>"; action = ":bnext<CR>"; options = { desc = "Next buffer"; }; }
      { mode = "n"; key = "[b"; action = ":bprevious<CR>"; }
      { mode = "n"; key = "]b"; action = ":bnext<CR>"; }
      { mode = "n"; key = "<Esc>"; action = ":noh<CR><Esc>"; }
      { mode = "n"; key = "<C-s>"; action = ":w<CR>"; }
      { mode = "v"; key = "<"; action = "<gv"; }
      { mode = "v"; key = ">"; action = ">gv"; }
      { mode = "n"; key = "<leader>e"; action = ":Neotree toggle<CR>"; options = { desc = "Toggle file explorer"; }; }
      { mode = "n"; key = "<leader>E"; action = ":Neotree reveal<CR>"; options = { desc = "Reveal in file explorer"; }; }
    ];

    # プラグイン
    plugins = {
      # LSP
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>cd" = "open_float";
          };
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "gy" = "type_definition";
            "gr" = "references";
            "K" = "hover";
            "gK" = "signature_help";
            "<leader>ca" = "code_action";
            "<leader>cr" = "rename";
            "<leader>cf" = "format";
          };
        };
        servers = {
          nil_ls.enable = true;
        };
      };

      # 補完
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                  require("luasnip").expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };

      luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;

      # UI
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "tokyonight";
            globalstatus = true;
          };
        };
      };

      bufferline = {
        enable = true;
        settings = {
          options = {
            diagnostics = "nvim_lsp";
            always_show_bufferline = false;
          };
        };
      };

      web-devicons.enable = true;
      notify = {
        enable = true;
        timeout = 3000;
      };
      dressing.enable = true;

      indent-blankline = {
        enable = true;
        settings = {
          indent.char = "│";
          scope.enabled = false;
        };
      };

      which-key = {
        enable = true;
        settings = {
          spec = [
            { __unkeyed-1 = "<leader>b"; group = "buffer"; }
            { __unkeyed-1 = "<leader>c"; group = "code"; }
            { __unkeyed-1 = "<leader>f"; group = "file/find"; }
            { __unkeyed-1 = "<leader>g"; group = "git"; }
            { __unkeyed-1 = "<leader>w"; group = "windows"; }
          ];
        };
      };

      alpha = {
        enable = true;
        layout = [
          { type = "padding"; val = 2; }
          {
            type = "text";
            val = [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
            opts = { position = "center"; hl = "Type"; };
          }
        ];
      };

      # エディター
      neo-tree = {
        enable = true;
        window = {
          position = "left";
          width = 30;
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader><space>" = { action = "find_files"; };
          "<leader>ff" = { action = "find_files"; };
          "<leader>fg" = { action = "live_grep"; };
          "<leader>/" = { action = "live_grep"; };
          "<leader>fb" = { action = "buffers"; };
          "<leader>fr" = { action = "oldfiles"; };
        };
        extensions.fzf-native.enable = true;
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
        };
      };

      comment.enable = true;
      nvim-autopairs.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          open_mapping = "[[<C-\\>]]";
        };
      };

      # Treesitter
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
    };
  };

  # direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # Git
  programs.git = {
    enable = true;
    userName = "lizelit";
    userEmail = "your.email@example.com";
  };

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -la";
      vim = "nvim";
      rebuild = "darwin-rebuild switch --flake ~/dotfiles";
    };
    
    initExtra = ''
      export EDITOR=nvim
    '';
  };

  programs.home-manager.enable = true;
}
