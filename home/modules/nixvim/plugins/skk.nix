{ pkgs, inputs, ... }:

{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "skk.nvim";
        version = "unstable";
        src = inputs.skk-nvim;
      })
    ];

    extraConfigLua = ''
      local skk_dir = vim.fn.expand("~/.local/share/skk")

      require("skk").setup({
        buffer_enter_key = "<F13>",
        cmdline_enter_key = "<C-j>",
        user_dictionary = skk_dir .. "/SKK-JISYO.user",
        dictionaries = {
          { path = skk_dir .. "/SKK-JISYO.emoji.utf8", encoding = "utf-8" },
          { path = skk_dir .. "/SKK-JISYO.fullname", encoding = "euc-jp" },
          { path = skk_dir .. "/SKK-JISYO.geo", encoding = "euc-jp" },
          { path = skk_dir .. "/skk-jisyo.imas.utf8", encoding = "utf-8" },
          { path = skk_dir .. "/SKK-JISYO.jinmei", encoding = "euc-jp" },
          { path = skk_dir .. "/SKK-JISYO.L", encoding = "euc-jp" },
          { path = skk_dir .. "/SKK-JISYO.propernoun", encoding = "euc-jp" },
        },
      })

      vim.keymap.set("i", "<F14>", function()
        require("skk").disable()
      end, {
        desc = "SKK: Disable",
      })
    '';
  };
}
