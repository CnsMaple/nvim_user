if false then
  return {
    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        local cmp = require "cmp"

        table.insert(opts.sources, { name = "cmp_tabnine", priority = 1249, keyword_length = 1, group_index = 1 })

        local lspkind = require "lspkind"
        lspkind.symbol_map["TabNine"] = ""
        vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#e0af68" })
        --
        -- local source_mapping = {
        --   buffer = "[Buffer]",
        --   nvim_lsp = "[LSP]",
        --   nvim_lua = "[Lua]",
        --   cmp_tabnine = "[Tabnine]",
        --   path = "[Path]",
        --   cmdline = "[Cmdline]",
        --   copilot = "[Copilot]",
        --   codeium = "[Codeium]",
        -- }
        --
        -- opts.formatting = {
        --   fields = { "kind", "abbr", "menu" },
        --   format = function(entry, vim_item)
        --     -- vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
        --     -- vim_item.menu = source_mapping[entry.source.name]
        --     if entry.source.name == "cmp_tabnine" then
        --       local detail = (entry.completion_item.labelDetails or {}).detail
        --       -- vim_item.kind = ""
        --       if detail and detail:find ".*%%.*" then vim_item.kind = vim_item.kind .. " " .. detail .. " " end
        --
        --       if (entry.completion_item.data or {}).multiline then vim_item.kind = vim_item.kind .. " " .. "[ML] " end
        --     end
        --     local maxwidth = 80
        --     vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
        --     return vim_item
        --   end,
        -- }

        return opts
      end,
    },
    {
      "tzachar/cmp-tabnine",
      build = vim.loop.os_uname().sysname == "Windows_NT" and "pwsh.exe -file .\\install.ps1" or "./install.sh",
      cmd = { "TabnineStatus", "TabnineDisable", "TabnineEnable", "TabnineToggle" },
      event = "User AstroFile",
      dependencies = {
        "hrsh7th/nvim-cmp",
      },
    },
  }
else
  return {}
end
