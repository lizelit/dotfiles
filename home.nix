{ config, pkgs, inputs, username ? "lizelit", homeDirectory ? "/Users/lizelit", ... }:

{
  # Home Manager basic configuration
  home = {
    inherit username homeDirectory;
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "safari";
      TERMINAL = "wezterm";
    };

    packages = with pkgs; [
      # CLI tools
      bat              # cat alternative
      eza              # ls alternative
      fd               # find alternative
      fzf              # fuzzy finder
      ripgrep          # grep alternative
      jq               # JSON processor
      yq               # YAML processor
      tree             # directory tree
      htop             # process monitor
      
      # Development tools
      skhd
      lazygit
      gh               # GitHub CLI
      
      # Language servers
      nil              # Nix LSP
      rust-analyzer
      nodePackages.typescript-language-server

      mas
      
      # Other tools
      ffmpeg
      imagemagick
      pandoc
    ];
    file.".skhdrc".source = ./config/skhdrc;
  };

  services.skhd.enable = true;

  # Neovim Nightly with basic plugins
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # Essential plugins
      plenary-nvim
      
      # LSP & Completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      
      # Treesitter
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-lua
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-json
        p.tree-sitter-yaml
        p.tree-sitter-markdown
        p.tree-sitter-rust
        p.tree-sitter-go
        p.tree-sitter-python
        p.tree-sitter-javascript
        p.tree-sitter-typescript
      ]))
      
      # UI
      telescope-nvim
      telescope-fzf-native-nvim
      nvim-web-devicons
      lualine-nvim
      
      # File management
      nvim-tree-lua
      
      # Git
      gitsigns-nvim
      fugitive
      
      # Themes
      catppuccin-nvim
      tokyonight-nvim
    ];
    
    extraLuaConfig = ''
      -- Leader key
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      
      -- Basic options
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 300
      vim.opt.cursorline = true
      vim.opt.undofile = true
      
      -- Color scheme
      vim.cmd.colorscheme("catppuccin-mocha")
      
      -- Treesitter
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
      }
      
      -- LSP
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      local on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end
      
      -- Configure language servers
      local servers = { 'nil_ls', 'rust_analyzer', 'tsserver', 'pyright', 'gopls' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
          on_attach = on_attach,
        }
      end
      
      -- Completion
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      
      -- Telescope
      require('telescope').setup {}
      require('telescope').load_extension('fzf')
      
      -- UI plugins
      require('lualine').setup {
        options = { theme = 'catppuccin' }
      }
      require('nvim-tree').setup {}
      require('gitsigns').setup {}
      
      -- Key mappings
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      
      -- General
      keymap('n', '<leader>w', ':w<CR>', opts)
      keymap('n', '<leader>q', ':q<CR>', opts)
      keymap('n', '<Esc>', ':nohlsearch<CR>', opts)
      
      -- Telescope
      keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
      keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
      keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
      
      -- File explorer
      keymap('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', opts)
    '';
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "lizelit";
    userEmail = "takku.hana@icloud.com";
    
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
    };
    
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    
    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
        line-numbers = true;
      };
    };
  };

  # Zsh with Oh My Zsh and useful plugins
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
      dr = "darwin-rebuild switch --flake ~/dotfiles";
      hm = "home-manager switch --flake ~/dotfiles";
    };
    
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "docker" ];
      theme = "robbyrussell";
    };
  };

  # Direnv for automatic environment switching
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Fzf fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--inline-info"
    ];
  };

  # XDG directories
  xdg = {
    enable = true;
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    cacheHome = "${homeDirectory}/.cache";
  };
}
