return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- 预览跳转
  {
    "nacro90/numb.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
      number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
      centered_peeking = true, -- Peeked line will be centered relative to window
    },
  },
  -- 字符反转
  {
    "nguyenvukhang/nvim-toggler",
    event = "BufEnter",
    config = function()
      require("nvim-toggler").setup {
        -- init.lua
        -- your own inverses
        inverses = {
          ["True"] = "False",
        },
        -- removes the default <leader>i keymap
        remove_default_keybinds = true,
        vim.keymap.set({ "n", "v" }, "<leader>i", require("nvim-toggler").toggle, { desc = "Toggle comment" }),
      }
    end,
  },
  -- 文本移动
  {
    "echasnovski/mini.move",
    version = "*",
    config = true,
    event = "BufEnter",
  },
  -- 文本统一替换
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    enabled = true,
    event = "VeryLazy",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
        { "<leader>fR", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  -- 比";"更好用的插件
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- 多文本选择
  {
    "mg979/vim-visual-multi",
    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    -- branch = "master",
    init = function()
      -- 禁用默认快捷键
      vim.cmd [[let g:VM_default_mappings = 0]]
      -- vim.g.VM_maps['Find Under'] = '<C-1>'
      -- vim.g.VM_maps['Find Subword Under'] = '<C-d>'
      -- vim.cmd([[ let g:VM_leader                     = {'default': ' ', 'visual': ' ', 'buffer': ' '}]])
      -- vim.cmd([[ let g:VM_maps                       = {}]])
      -- vim.cmd([[ let g:VM_maps['Find Under']         = '<C-k>']])
      -- vim.cmd([[ let g:VM_maps['Find Subword Under'] = '<C-k>']])
      -- vim.cmd([[ let g:VM_maps['Find Next']          = '']])
      -- vim.cmd([[ let g:VM_maps['Find Prev']          = '']])
      -- vim.cmd([[ let g:VM_maps['Remove Region']      = 'q']])
      -- vim.cmd([[ let g:VM_maps['Skip Region']        = '<c-n>']])
      -- vim.cmd([[ let g:VM_maps["Undo"]               = 'l']])
      -- vim.cmd([[ let g:VM_maps["Redo"]               = '<C-r>']])
    end,
  },
}
