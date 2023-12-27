if true then
  return {
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "Exafunction/codeium.nvim" },
      opts = function(_, opts)
        local cmp = require "cmp"

        table.insert(opts.sources, { name = "codeium", priority = 1250, keyword_length = 0, group_index = 1 })

        local lspkind = require "lspkind"
        lspkind.symbol_map["Codeium"] = ""

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
        local nvim_data_codeium_path = vim.fn.stdpath "data" .. "\\codeium"

        return {
          config_path = nvim_data_codeium_path .. "\\config.json",
          bin_path = nvim_data_codeium_path .. "\\bin",
        }
      end,
    },
  }
else
  return {}
end
