return {
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
        vim.keymap.set({ "n", "v" }, "<leader>i", require("nvim-toggler").toggle, { desc = "Reverse Text" }),
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
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
  -- 更好的主题
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = false,
    },
  },
  -- markdown 预览
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    ft = { "markdown" },
    opts = function(_, opts)
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      return opts
    end,
    cmd = {
      "PeekOpen",
      "PeekClose",
    },
  },
  -- markdown 图片粘贴
  {
    "CnsMaple/clipboard-image.nvim",
    ft = { "markdown" },
    opts = {
      markdown = {
        img_dir = { "%:p:h", "img" },
        img_dir_txt = "img",
        img_name = function() return vim.fn.input { prompt = "Enter file name: " } end,
      },
    },
    cmd = { "PasteImg" },
  },
  -- markdown 更多语法支持
  {
    "jakewvincent/mkdnflow.nvim",
    enabled = true,
    ft = { "markdown" },
    config = function() require("mkdnflow").setup {} end,
  },
  -- 调试的虚拟文本
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
    opts = {},
  },
  -- 更好的标记插件
  {
    "chentoast/marks.nvim",
    event = "User AstroFile",
    opts = {
      excluded_filetypes = {
        "qf",
        "NvimTree",
        "toggleterm",
        "TelescopePrompt",
        "alpha",
        "netrw",
        "neo-tree",
      },
    },
  },
  -- 窗口移动插件
  {
    "sindrets/winshift.nvim",
    event = "User AstroFile",
  },
}
