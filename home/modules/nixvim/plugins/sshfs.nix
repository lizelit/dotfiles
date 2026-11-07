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

    extraConfigLua = ''
      require("sshfs").setup({
        mounts = {
          base_dir = vim.fn.expand("$HOME") .. "/mnt",
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
