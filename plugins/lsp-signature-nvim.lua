-- e1ccbdc

vim.keymap.set(
  { "n", "i" },
  "<M-s>",
  function() require("lsp_signature").toggle_float_win() end,
  { silent = true, noremap = true, desc = "toggle signature" }
)

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "ray-x/lsp_signature.nvim",
    opts = {
      hint_enable = false, -- disable hints as it will crash in some terminal
    },
  },
}
