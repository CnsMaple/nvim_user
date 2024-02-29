-- return {
--   "karb94/neoscroll.nvim",
--   event = "VeryLazy",
--   enabled = vim.g.neovide == nil,
--   opts = {},
-- }
return {
  "declancm/cinnamon.nvim",
  enabled = vim.g.neovide == nil,
  event = "VeryLazy",
  opts = {
    -- default_delay = 1,
    -- extra_keymaps = false, -- Create extra keymaps.
    -- extended_keymaps = false, -- Create extended keymaps.
    -- scroll_limit = 50,
  },
}
