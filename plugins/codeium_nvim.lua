if false then
  return {
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "Exafunction/codeium.nvim" },
      opts = function(_, opts)
        local cmp = require "cmp"

        opts.sources = cmp.config.sources {
          { name = "codeium", keyword_length = 1, priority = 100 },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
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
      build = ":Codeium Auth",
      opts = {},
      config = function(_, opts) require("codeium").setup(opts) end,
    },
  }
else
  return {}
end
