-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    ["<S-h>"] = { "^", desc = "Move to first non-blank character of line" },
    ["<S-l>"] = { "$", desc = "Move to end of line" },

    ["U"] = { "<cmd>redo<CR>", desc = "redo" },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>ur"] = {
      "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
      desc = "Redraw / clear hlsearch / diff update",
    },
  },
  v = {
    ["<S-h>"] = { "^", desc = "Move to first non-blank character of line" },
    ["<S-l>"] = { "$g_", desc = "Move to end of line" },
  },
  i = {
    ["jj"] = { "<cmd>nohl<cr><esc>", desc = "exit insert mode" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
