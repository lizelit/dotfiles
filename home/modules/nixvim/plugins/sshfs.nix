{ inputs, pkgs, ... }:

let
  sshfs-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "sshfs.nvim";
    version = "unstable";
    src = inputs.sshfs-nvim;
  };
in
{
  programs.nixvim = {
    extraPlugins = [
      sshfs-nvim
    ];

    extraPackages = [
      pkgs.sshfs-fuse
    ];

    extraConfigLua = ''
      -- vim.env.PATH = "/etc/profiles/per-user/lizelit/bin:" .. vim.env.PATH
      -- vim.env.TEXMFCNF = nil
      require("sshfs").setup({
        connections = {
          ssh_configs = {
            vim.fn.expand("~/.ssh/config"),
          },
          sshfs_options = {
            backend = "fskit",
            noappledouble = true,
            noapplexattr = true,
            reconnect = true,
            ConnectTimeout = 5,
            compression = "yes",
            ServerAliveInterval = 15,
            ServerAliveCountMax = 3,
          },
        },

        mounts = {
          base_dir = vim.fn.expand("~/mnt"),
        },

        hooks = {
          on_exit = {
            auto_unmount = true,
            clean_mount_folders = true,
          },
          on_mount = {
            auto_change_to_dir = false,
            auto_run = "none",
          },
        },
      })
    '';
  };
}
