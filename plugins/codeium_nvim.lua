if true then
  return {
    {
      "hrsh7th/nvim-cmp",
      -- dependencies = { "Exafunction/codeium.nvim" },
      opts = function(_, opts)
        local cmp = require "cmp"

        table.insert(opts.sources, { name = "codeium", priority = 1250, keyword_length = 1, group_index = 1 })

        local lspkind = require "lspkind"
        lspkind.symbol_map["Codeium"] = ""
        vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#32d2bf" })

        return opts
      end,
    },
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      event = "User AstroFile",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      opts = function(_, opts)
        local Path = require "plenary.path"
        -- local nvim_data_codeium_path = vim.fn.stdpath "data" .. "\\codeium"
        local nvim_data_codeium_path = tostring(Path:new(vim.fn.stdpath "data", "codeium"))

        -- opts.config_path = nvim_data_codeium_path .. "\\config.json"
        opts.config_path = tostring(Path:new(nvim_data_codeium_path, "config.json"))
        -- opts.bin_path = nvim_data_codeium_path .. "\\bin"
        opts.bin_path = tostring(Path:new(nvim_data_codeium_path, "bin"))

        return opts
      end,
    },
  }
else
  return {}
end
