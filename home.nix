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
  };

  # Neovim Nightly with basic plugins
  

programs.neovim = {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  
  plugins = with pkgs.vimPlugins; [
    # LSP基盤
    nvim-lspconfig
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    
    # カラースキーム
    tokyonight-nvim
    
    # ファイラー
    nvim-tree-lua
    nvim-web-devicons
    
    # ファジーファインダー
    telescope-nvim
    plenary-nvim
    
    # タブ・バッファライン
    bufferline-nvim
    
    # ホーム画面
    alpha-nvim
    
    # ステータスライン
    lualine-nvim
    
    # シンタックスハイライト
    nvim-treesitter.withAllGrammars
    
    # Git統合
    gitsigns-nvim
    
    # コメントアウト
    comment-nvim
    
    # 括弧の自動補完
    nvim-autopairs
    
    # インデントガイド
    indent-blankline-nvim
    
    # キーバインド表示
    which-key-nvim
  ];
  
  extraPackages = with pkgs; [
    ripgrep
    fd
    gcc
  ];
  
  programs.neovim = {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  
  plugins = with pkgs.vimPlugins; [
    # LSP基盤
    nvim-lspconfig
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    
    # カラースキーム
    tokyonight-nvim
    
    # ファイラー
    nvim-tree-lua
    nvim-web-devicons
    
    # ファジーファインダー
    telescope-nvim
    plenary-nvim
    
    # タブ・バッファライン
    bufferline-nvim
    
    # ホーム画面
    alpha-nvim
    
    # ステータスライン
    lualine-nvim
    
    # シンタックスハイライト
    nvim-treesitter.withAllGrammars
    
    # Git統合
    gitsigns-nvim
    
    # コメントアウト
    comment-nvim
    
    # 括弧の自動補完
    nvim-autopairs
    
    # インデントガイド
    indent-blankline-nvim
    
    # キーバインド表示
    which-key-nvim
  ];
  
  extraPackages = with pkgs; [
    ripgrep
    fd
    gcc
  ];
  extraLuaConfig = ''
    -- カラースキーム
    vim.cmd[[colorscheme tokyonight]]
    
    -- 基本設定
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    
    -- nvim-tree
    require("nvim-tree").setup()
    vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
    
    -- telescope
    require('telescope').setup{}
    vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
    vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')
    vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')
    
    -- bufferline
    require("bufferline").setup{}
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>')
    
    -- lualine
    require('lualine').setup()
    
    -- alpha
    require('alpha').setup(require('alpha.themes.startify').config)
    
    -- treesitter
    require('nvim-treesitter.configs').setup {
      highlight = { enable = true },
      indent = { enable = true },
    }
    
    -- gitsigns
    require('gitsigns').setup()
    
    -- comment
    require('Comment').setup()
    
    -- autopairs
    require('nvim-autopairs').setup()
    
    -- indent-blankline
    require('ibl').setup()
    
    -- which-key
    require('which-key').setup()
    
    -- LSP設定
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    
    -- LSPキーマップ
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
    
    -- nvim-cmp
    local cmp = require('cmp')
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      })
    })
  '';
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
      dr = "sudo darwin-rebuild switch --flake ~/dotfiles";
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
