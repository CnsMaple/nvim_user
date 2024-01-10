if true then
  return {
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "zbirenbaum/copilot.lua", "zbirenbaum/copilot-cmp" },
      opts = function(_, opts)
        table.insert(opts.sources, { name = "copilot", priority = 1250, keyword_length = 0, group_index = 1 })

        local lspkind = require "lspkind"
        lspkind.symbol_map["Copilot"] = ""
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

        return opts
      end,
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      enabled = true,
      event = "User AstroFile",
      opts = {
        suggestion = {
          enabled = false,
        },
        panel = {
          enabled = false,
        },
        filetypes = {
          markdown = true,
          help = true,
        },
        -- copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 10, -- #completions for panel
              inlineSuggestCount = 5, -- #completions for getCompletions
            },
          },
        },
      },
    },
    {
      "zbirenbaum/copilot-cmp",
      enabled = true,
      event = "User AstroFile",
      dependencies = {
        { "zbirenbaum/copilot.lua" },
      },
      opts = {},
    },
  }
else
  return {}
end
