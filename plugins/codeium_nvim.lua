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
      dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
      },
      opts = {},
    },
  }
else
  return {}
end
