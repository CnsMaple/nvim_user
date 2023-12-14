if true then
  return {
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "Exafunction/codeium.nvim" },
      opts = function(_, opts)
        local cmp = require "cmp"

        opts.sources = cmp.config.sources {
          { name = "codeium", keyword_length = 1, priority = 1000 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }

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
      config = function(_, opts) require("codeium").setup(opts) end,
    },
  }
else
  return {}
end
