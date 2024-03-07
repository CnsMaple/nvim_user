local utils = require "astronvim.utils"
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "python", "toml" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "pyright" }) end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "black", "isort" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "python")
      if not opts.handlers then opts.handlers = {} end
      opts.handlers.python = function() end -- make sure python doesn't get set up by mason-nvim-dap, it's being set up by nvim-dap-python
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      {
        "<leader>lV",
        function()
          vim.cmd "VenvSelect"
          vim.cmd "LspRestart"
        end,
        desc = "Select VirtualEnv",
      },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      {
        "<leader>lv",
        function()
          vim.cmd "VenvSelectCached"
          vim.cmd "LspRestart"
        end,
        desc = "Select VirtualEnvCached",
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    config = function(_, opts)
      local path = require("mason-registry").get_package("debugpy"):get_install_path()

      if vim.fn.has "win32" == 1 then
        -- 在Windows上运行的代码
        path = path .. "/venv/scripts/python"
      else
        -- 在其他操作系统上运行的代码
        path = path .. "/venv/bin/python"
      end
      require("dap-python").setup(path, opts)
    end,
  },
}
