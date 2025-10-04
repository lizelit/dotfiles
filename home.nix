{
  config,
  lib,
  pkgs,
  username,
  homeDirectory,
  ...
}: {
  home.username = lib.mkForce username;
  home.homeDirectory = lib.mkForce homeDirectory;
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
    fzf
    bat
    eza

    python3
    black
    isort
    ruff

    ghc
    haskell-language-server
    fourmolu

    nodejs
    nodePackages.typescript
    nodePackages.prettier
    nodePackages.eslint

    rustc
    cargo
    rust-analyzer
    rustfmt

    texlive.combined.scheme-full

    lua-language-server
    stylua
    alejandra
  ];

  programs.wezterm = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
  };

  # NixVim設定
  programs.nixvim = {
    enable = true;

    # LazyVimのデフォルト設定
    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 50;
      timeoutlen = 300;
      splitbelow = true;
      splitright = true;
      ignorecase = true;
      smartcase = true;
      mouse = "a";
      clipboard = "unnamedplus";
      completeopt = ["menu" "menuone" "noselect"];
    };

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    # カラースキーム
    # colorschemes.everforest = {
    #   enable = true;
    #   settings = {
    #     integrations = {
    #       cmp = true;
    #       gitsigns = true;
    #       treesitter = true;
    #       notify = true;
    #       mini = true;
    #       telescope = true;
    #       neotree = true;
    #       transparent_background = 2;
    #     };
    #   };
    # };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        term_colors = true;
      };
    };

    plugins = {
      # アイコン（明示的に有効化）
      web-devicons.enable = true;

      lean.enable = true;

      remote-nvim = {
        enable = true;
      };

      # UI関連

      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "auto";
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
            offsets = [
              {
                filetype = "neo-tree";
                text = "File Explorer";
                highlight = "Directory";
                text_align = "left";
              }
            ];
          };
        };
      };

      # ファイルエクスプローラー
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        window = {
          width = 30;
          position = "left";
        };
      };

      # ファジーファインダー
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
        settings = {
          defaults = {
            prompt_prefix = " ";
            selection_caret = " ";
            path_display = ["truncate"];
            sorting_strategy = "ascending";
            layout_config = {
              horizontal = {
                prompt_position = "top";
                preview_width = 0.55;
              };
              width = 0.87;
              height = 0.80;
            };
          };
        };
      };

      # Treesitter
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
        };
      };

      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 3;
        };
      };

      # LSP
      lsp = {
        enable = true;

        servers = {
          # Nix
          nil_ls.enable = true;

          # Python
          pyright.enable = true;
          ruff.enable = true;

          # Haskell
          hls = {
            enable = true;
            installGhc = false;
          };

          # TypeScript/JavaScript
          ts_ls.enable = true;
          eslint.enable = true;

          # Rust
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };

          # LaTeX
          texlab.enable = true;

          # Lua
          lua_ls.enable = true;
        };

        keymaps = {
          diagnostic = {
            "<leader>cd" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gr" = "references";
            "gi" = "implementation";
            "gt" = "type_definition";
            "K" = "hover";
            "<leader>ca" = "code_action";
            "<leader>cr" = "rename";
            "<leader>cf" = "format";
          };
        };
      };

      # 補完設定（修正版）
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
          sources = [
            {
              name = "nvim_lsp";
              priority = 1000;
            }
            {
              name = "luasnip";
              priority = 750;
            }
            {
              name = "path";
              priority = 250;
            }
            {
              name = "buffer";
              priority = 500;
            }
          ];
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
      };

      # これらは順序が重要
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      friendly-snippets.enable = true;

      # Git統合
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add.text = "▎";
            change.text = "▎";
            delete.text = "";
            topdelete.text = "";
            changedelete.text = "▎";
            untracked.text = "▎";
          };
          current_line_blame = true;
          current_line_blame_opts = {
            delay = 300;
          };
        };
      };

      lazygit.enable = true;

      # コード編集補助
      comment.enable = true;
      nvim-autopairs.enable = true;
      nvim-surround.enable = true;

      which-key = {
        enable = true;
        settings = {
          spec = [
            {
              __unkeyed-1 = "<leader>f";
              group = "Find";
            }
            {
              __unkeyed-1 = "<leader>g";
              group = "Git";
            }
            {
              __unkeyed-1 = "<leader>c";
              group = "Code";
            }
            {
              __unkeyed-1 = "<leader>b";
              group = "Buffer";
            }
            {
              __unkeyed-1 = "<leader>s";
              group = "Split";
            }
            {
              __unkeyed-1 = "<leader>x";
              group = "Diagnostics";
            }
          ];
        };
      };

      # インデントガイド
      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            enabled = true;
            show_start = true;
            show_end = true;
          };
        };
      };

      # 通知
      notify = {
        enable = true;
        settings = {
          timeout = 3000;
          max_width = 50;
        };
      };

      # ターミナル
      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          float_opts = {
            border = "curved";
            height = 30;
            width = 130;
          };
          open_mapping = "[[<c-\\>]]";
        };
      };

      # ヤンク履歴
      yanky.enable = true;

      # その他便利プラグイン
      todo-comments.enable = true;
      trouble.enable = true;
      flash.enable = true;
      persistence.enable = true;

      # フォーマッター
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            # Nix
            nix = ["alejandra"];

            # Python
            python = [
              "black"
              "isort"
            ];

            # Haskell
            haskell = ["fourmolu"];

            # TypeScript/JavaScript
            javascript = ["prettier"];
            typescript = ["prettier"];
            javascriptreact = ["prettier"];
            typescriptreact = ["prettier"];

            # Rust
            rust = ["rustfmt"];

            # LaTeX
            latex = ["latexindent"];
            tex = ["latexindent"];

            # Lua
            lua = ["stylua"];
          };
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
        };
      };

      # Linter
      lint = {
        enable = true;
        lintersByFt = {
          # Python
          python = ["ruff"];

          # JavaScript/TypeScript
          javascript = ["eslint"];
          typescript = ["eslint"];
          javascriptreact = ["eslint"];
          typescriptreact = ["eslint"];

          # Haskell (hlintはLSPに含まれることが多い)
          # haskell = ["hlint"];

          # LaTeX
          latex = ["chktex"];
          tex = ["chktex"];
        };
      };
    };

    # キーマッピング（LazyVim風）
    keymaps = [
      # 基本操作
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options.desc = "Clear search highlights";
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options.desc = "Quit all";
      }

      # Telescope
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<cr>";
        options.desc = "Recent Files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live Grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Buffers";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
        options.desc = "Help";
      }
      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>Telescope grep_string<cr>";
        options.desc = "Word under cursor";
      }
      {
        mode = "n";
        key = "<leader><space>";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Switch Buffer";
      }

      # Neo-tree
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Explorer";
      }
      {
        mode = "n";
        key = "<leader>o";
        action = "<cmd>Neotree focus<cr>";
        options.desc = "Focus Explorer";
      }

      # Buffer操作
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>bprevious<cr>";
        options.desc = "Prev Buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>bnext<cr>";
        options.desc = "Next Buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options.desc = "Delete Buffer";
      }
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>e #<cr>";
        options.desc = "Switch to Other Buffer";
      }

      # Window操作
      {
        mode = "n";
        key = "<leader>ww";
        action = "<C-W>p";
        options.desc = "Other window";
      }
      {
        mode = "n";
        key = "<leader>wd";
        action = "<C-W>c";
        options.desc = "Delete window";
      }
      {
        mode = "n";
        key = "<leader>w-";
        action = "<C-W>s";
        options.desc = "Split window below";
      }
      {
        mode = "n";
        key = "<leader>w|";
        action = "<C-W>v";
        options.desc = "Split window right";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Go to left window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Go to lower window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Go to upper window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Go to right window";
      }

      # Git
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options.desc = "LazyGit";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Gitsigns blame_line<cr>";
        options.desc = "Blame line";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>Gitsigns diffthis<cr>";
        options.desc = "Diff this";
      }
      {
        mode = "n";
        key = "]h";
        action = "<cmd>Gitsigns next_hunk<cr>";
        options.desc = "Next Hunk";
      }
      {
        mode = "n";
        key = "[h";
        action = "<cmd>Gitsigns prev_hunk<cr>";
        options.desc = "Prev Hunk";
      }

      # Diagnostics
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xl";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xq";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Quickfix List (Trouble)";
      }

      # Terminal
      {
        mode = "n";
        key = "<leader>ft";
        action = "<cmd>ToggleTerm<cr>";
        options.desc = "Terminal";
      }
      {
        mode = "t";
        key = "<C-\\>";
        action = "<cmd>close<cr>";
        options.desc = "Hide Terminal";
      }

      # Better indenting
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "Indent left";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "Indent right";
      }

      # Move lines
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>m .+1<cr>==";
        options.desc = "Move down";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>m .-2<cr>==";
        options.desc = "Move up";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":m '>+1<cr>gv=gv";
        options.desc = "Move down";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m '<-2<cr>gv=gv";
        options.desc = "Move up";
      }

      # Yanky
      {
        mode = "n";
        key = "<leader>p";
        action = "<cmd>Telescope yank_history<cr>";
        options.desc = "Yank History";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "p";
        action = "<Plug>(YankyPutAfter)";
        options.desc = "Put after";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "P";
        action = "<Plug>(YankyPutBefore)";
        options.desc = "Put before";
      }
      {
        mode = "n";
        key = "<c-p>";
        action = "<Plug>(YankyCycleForward)";
        options.desc = "Cycle forward";
      }
      {
        mode = "n";
        key = "<c-n>";
        action = "<Plug>(YankyCycleBackward)";
        options.desc = "Cycle backward";
      }

      # Save file
      {
        mode = [
          "i"
          "x"
          "n"
          "s"
        ];
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        options.desc = "Save file";
      }
    ];
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
    userEmail = "takku.hana@icloud.com";
  };

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Basic aliases
      ll = "eza -la";
      la = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      grep = "rg";

      # Git aliases
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";

      # Nix aliases
      nr = "nix run";
      ns = "nix shell";
      nf = "nix flake";

      # Darwin aliases
      dr = "sudo darwin-rebuild switch --flake ~/dotfiles";
      hm = "home-manager switch --flake ~/dotfiles";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf" "docker"];
      theme = "robbyrussell";
    };
  };

  xdg = {
    enable = true;
    configFile."wezterm/wezterm.lua".source = ./config/wezterm.lua;
    configFile."alacritty/alacritty.toml".source = ./config/alacritty.toml;
  };

  programs.home-manager.enable = true;
}
