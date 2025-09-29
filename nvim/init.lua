local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
 {
   "folke/noice.nvim",
   event = "VeryLazy",
   opts = {
     -- add any options here
   },
   dependencies = {
     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
     "MunifTanjim/nui.nvim",
     -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
     --   If not available, we use `mini` as the fallback
     "rcarriga/nvim-notify",
     }
 }
})
