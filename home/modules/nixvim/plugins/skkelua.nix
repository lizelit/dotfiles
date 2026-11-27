{ inputs, pkgs, ... }:

let
  skkelua = pkgs.vimUtils.buildVimPlugin {
    pname = "skkelua.nvim";
    version = "unstable";
    src = inputs.skkelua;
  };
in
{
  programs.nixvim = {
    extraPlugins = [
      skkelua
    ];

    extraConfigLua = ''
      local skk_dir = vim.fn.expand("~/.local/share/skk")

      require("skkelua").config({
        globalDictionaries = {
          { skk_dir .. "/SKK-JISYO.L", "euc-jp" },
          { skk_dir .. "/SKK-JISYO.propernoun", "euc-jp" },
          { skk_dir .. "/skk-jisyo.imas.utf8", "utf-8" },
          { skk_dir .. "/SKK-JISYO.geo", "euc-jp" },
          { skk_dir .. "/SKK-JISYO.jinmei", "euc-jp" },
          { skk_dir .. "/SKK-JISYO.fullname", "euc-jp" },
          { skk_dir .. "/SKK-JISYO.emoji.utf8", "utf-8" },
        },

        eggLikeNewline = true,
        registerConvertResult = true,

        indicator = {
          enabled = true,
          alwaysShown = false,
          fadeOutMs = 0,
        },
      })

      -- Initialize
      require("skkelua").initialize()

      -- Keymaps
      -- F13: Toggle SKK (Insert mode)
      vim.keymap.set(
        "i",
        "<F13>",
        "<Plug>(skkelua-toggle)",
        { silent = true, desc = "SKK: Toggle" }
      )

      -- C-j: Toggle SKK (Command-line mode)
      vim.keymap.set(
        "c",
        "<C-j>",
        "<Plug>(skkelua-toggle)",
        { silent = true, desc = "SKK: Toggle" }
      )

      -- F16: Explicitly disable SKK
      vim.keymap.set(
        "i",
        "<F16>",
        "<Plug>(skkelua-disable)",
        { silent = true, desc = "SKK: Disable" }
      )

      -- Karabiner-Elements integration
      local karabiner_cli =
        "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"

      local function set_karabiner_insert_mode(enabled)
        vim.system({
          karabiner_cli,
          "--set-variables",
          vim.json.encode({
            neovim_in_insert_mode = enabled and 1 or 0,
          }),
        }, {}, function(result)
          if result.code ~= 0 then
            vim.schedule(function()
              vim.notify(
                "Failed to update Karabiner variable: "
                  .. (result.stderr or ""),
                vim.log.levels.WARN
              )
            end)
          end
        end)
      end

      -- Enter / leave Insert mode
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          set_karabiner_insert_mode(true)
        end,
      })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          set_karabiner_insert_mode(false)
        end,
      })

      -- Disable while Neovim is unfocused or exiting
      vim.api.nvim_create_autocmd({
        "FocusLost",
        "VimLeavePre",
      }, {
        callback = function()
          set_karabiner_insert_mode(false)
        end,
      })

      -- Restore state when Neovim regains focus
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          vim.schedule(function()
            local mode = vim.api.nvim_get_mode().mode
            set_karabiner_insert_mode(mode:sub(1, 1) == "i")
          end)
        end,
      })

      -- Start with the variable disabled
      set_karabiner_insert_mode(false)
    '';
  };
}
