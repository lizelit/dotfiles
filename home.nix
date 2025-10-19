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
    fastfetch
    yazi
    lazygit

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

    elan

    texlive.combined.scheme-full

    lua-language-server
    stylua
    alejandra

    zellij
  ];

  programs.alacritty = {
    enable = true;
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      number = true;
      relativenumber = true;
      cmdheight = 0;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      showmode = false;
      smartindent = true;
      cursorline = true;
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

    colorschemes.gruvbox-material-nvim = {
      enable = true;
    };

    plugins = {
      web-devicons.enable = true;

      lean.enable = true;

      remote-nvim = {
        enable = true;
      };

      zen-mode.enable = true;

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

      noice = {
        enable = true;
      };

      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        window = {
          width = 30;
          position = "left";
        };
      };

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

      lsp = {
        enable = true;

        servers = {
          nil_ls.enable = true;

          pyright.enable = true;
          ruff.enable = true;

          hls = {
            enable = true;
            installGhc = false;
          };

          ts_ls.enable = true;
          eslint.enable = true;

          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };

          texlab.enable = true;

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

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      friendly-snippets.enable = true;

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

      notify = {
        enable = true;
        settings = {
          timeout = 3000;
          max_width = 50;
        };
      };

      yanky.enable = true;

      todo-comments.enable = true;
      trouble.enable = true;
      flash.enable = true;
      persistence.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = ["alejandra"];

            python = [
              "black"
              "isort"
            ];

            haskell = ["fourmolu"];

            javascript = ["prettier"];
            typescript = ["prettier"];
            javascriptreact = ["prettier"];
            typescriptreact = ["prettier"];

            rust = ["rustfmt"];

            latex = ["latexindent"];
            tex = ["latexindent"];

            lua = ["stylua"];
          };
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
        };
      };

      lint = {
        enable = true;
        lintersByFt = {
          python = ["ruff"];

          javascript = ["eslint"];
          typescript = ["eslint"];
          javascriptreact = ["eslint"];
          typescriptreact = ["eslint"];

          latex = ["chktex"];
          tex = ["chktex"];
        };
      };
    };

    keymaps = [
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
      {
        mode = "n";
        key = "<leader>z";
        action = "<cmd>ZenMode<cr>";
        options.desc = "Toggle ZenMode";
      }
    ];
    autoCmd = [
      {
        event = "InsertLeave";
        pattern = "*";
        command = "lua vim.fn.jobstart({'macism', 'com.apple.keylayout.ABC'})";
      }
      {
        event = "FocusGained";
        pattern = "*";
        command = "lua if vim.fn.mode() == 'n' then vim.fn.jobstart({'macism', 'com.apple.keylayout.ABC'}) end";
      }
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "lizelit";
    userEmail = "lizelit.you@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = ["history" "completion"];
    syntaxHighlighting.enable = true;

    initContent = ''
      zel() {
        if [ -z "$1" ]; then
          echo "Usage: zel <directory>"
          return 1
        fi

        local dir="$1"
        if [ ! -d "$dir" ]; then
          echo "Error: '$dir' is not a directory"
          return 1
        fi

        local session
        session=$(basename "$(realpath "$dir")")

        cd "$dir" || return

        if zellij list-sessions | grep -q "^$session$"; then
          zellij attach "$session"
        else
          zellij attach --create "$session"
        fi
      }
    '';

    shellAliases = {
      ll = "eza -la";
      la = "eza -la";
      lt = "eza --tree";
      cat = "bat";
      grep = "rg";

      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";

      nr = "nix run";
      ns = "nix shell";
      nf = "nix flake";

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
    configFile."alacritty/alacritty.toml".source = ./config/alacritty.toml;
    configFile."zellij/config.kdl".source = ./config/zellij.kdl;
    configFile."yazi/keymap.toml".source = ./config/keymap.toml;
    configFile."zellij/layouts".source = ./config/layouts;
    configFile."starship.toml".source = ./config/starship.toml;
    configFile."yazi/yazi.toml".source = ./config/yazi.toml;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox";
    };
    themes = {
      gruvbox = ''
        theme[main_bg]="#282828"
        theme[main_fg]="#d4be98"
        theme[title]="#d4be98"
        theme[hi_fg]="#ea6962"
        theme[selected_bg]="#d8a657"
        theme[selected_fg]="#282828"
        theme[inactive_fg]="#282828"
        theme[graph_text]="#665c54"
        theme[proc_misc]="#a9b665"
        theme[cpu_box]="#7c6f64"
        theme[mem_box]="#7c6f64"
        theme[net_box]="#7c6f64"
        theme[proc_box]="#7c6f64"
        theme[div_line]="#7c6f64"
        theme[temp_start]="#7daea3"
        theme[temp_mid]="#e78a4e"
        theme[temp_end]="#ea6962"
        theme[cpu_start]="#a9b665"
        theme[cpu_mid]="#d8a657"
        theme[cpu_end]="#ea6962"
        theme[free_start]="#89b482"
        theme[free_mid]=""
        theme[free_end]=""
        theme[cached_start]="#7daea3"
        theme[cached_mid]=""
        theme[cached_end]=""
        theme[available_start]="#d8a657"
        theme[available_mid]=""
        theme[available_end]=""
        theme[used_start]="#ea6962"
        theme[used_mid]=""
        theme[used_end]=""
        theme[download_start]="#e78a4e"
        theme[download_mid]=""
        theme[download_end]=""
        theme[upload_start]="#d3869b"
        theme[upload_mid]=""
        theme[upload_end]=""
      '';
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
