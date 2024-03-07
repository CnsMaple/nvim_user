-- e7b94c5

return {
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fix" },
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info", alt = { "todo" } },
        HACK = { icon = " ", color = "warning", alt = { "hack" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warn" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "perf" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "note" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED", "test" } },
      },
      -- highlight = {
      --   comments_only = false,
      -- },
    },
    event = "User AstroFile",
  },
}
