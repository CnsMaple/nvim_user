if false then
  return {
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "zbirenbaum/copilot.lua", "zbirenbaum/copilot-cmp" },
      opts = function(_, opts)
        local cmp, copilot = require "cmp", require "copilot.suggestion"

        opts.sources = cmp.config.sources {
          { name = "copilot", keyword_length = 0, priority = 1250 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }

        cmp.event:on("menu_opened", function() vim.b.copilot_suggestion_hidden = true end)
        cmp.event:on("menu_closed", function() vim.b.copilot_suggestion_hidden = false end)

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
          auto_trigger = false,
          debounce = 150,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-h>",
          },
        },
        filetypes = {
          markdown = true,
          help = true,
        },

        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "k",
            jump_next = "j",
            accept = "<CR>",
            refresh = "<C-r>",
            -- need in insert mode
            open = "<M-\\>",
          },
          layout = {
            position = "right", -- | top | left | right
            ratio = 0.5,
          },
        },
        -- copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 3, -- #completions for panel
              inlineSuggestCount = 3, -- #completions for getCompletions
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
      opts = {
        fix_pairs = true,
      },
    },
  }
else
  return {}
end
