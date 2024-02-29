return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "███    ███  █████  ██████  ██      ███████ ",
        "████  ████ ██   ██ ██   ██ ██      ██      ",
        "██ ████ ██ ███████ ██████  ██      ███████ ",
        "██  ██  ██ ██   ██ ██      ██      ██      ",
        "██      ██ ██   ██ ██      ███████ ███████ ",
      }
      return opts
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          -- set to `false` to disable one of the mappings
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<TAB>",
          node_decremental = "<BS>",
        },
      },
      -- 可以避免一些错误的缩进
      indent = { enable = false },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.mapping["<C-y>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" })
      opts.mapping["<Tab>"] = nil
      opts.mapping["<S-Tab>"] = nil

      opts.mapping["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }
      opts.mapping["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }
      opts.mapping["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }
      opts.mapping["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }

      local lspkind = require "lspkind"

      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        -- fields = { "kind", "abbr"},
        format = function(entry, vim_item)
          local abbrMaxWidth = 80
          local menuMaxWidth = 20
          vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
          vim_item.abbr = string.sub(vim_item.abbr, 1, abbrMaxWidth)
          if vim_item.menu then vim_item.menu = string.sub(vim_item.menu, 1, menuMaxWidth) end
          return vim_item
        end,
      }

      opts["experimental"] = {
        ghost_text = true,
      }
      return opts
    end,
  },
  -- 开启run/debug功能
  {
    "mfussenegger/nvim-dap",
    enabled = true,
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
    keys = {
      {
        "<leader>db",
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        { silent = true },
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
        { silent = true },
        desc = "Clear Breakpoints",
      },
      {
        "<leader>dC",
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        { silent = true },
        desc = "Conditional Breakpoint",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = function(_, opts)
      opts.layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "right",
          size = 25,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 8,
        },
      }
      -- 防止文字超过窗口
      opts.expand_lines = false
      return opts
    end,
    config = function(plugin, opts)
      -- run default AstroNvim nvim-dap-ui configuration function
      require "plugins.configs.nvim-dap-ui"(plugin, opts)

      -- disable dap events that are created
      -- local dap = require "dap"
      -- dap.listeners.after.event_initialized["dapui_config"] = nil
      -- dap.listeners.before.event_terminated["dapui_config"] = nil
      -- dap.listeners.before.event_exited["dapui_config"] = nil
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
        },
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    enabled = false,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      table.insert(opts.statusline, 7, {
        condition = function()
          local session = require("dap").session()
          return session ~= nil
        end,
        provider = function() return " " .. require("dap").status() end,
        hl = "Debug",
        -- see Click-it! section for clickable actions
      })

      -- return the final configuration table
      return opts
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            -- 整个窗口的高度
            height = 0.99,
            preview_cutoff = 1,
            preview_height = 0.55,
            prompt_position = "bottom",
            width = 0.9,
          },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  -- {
  --   "rcarriga/nvim-notify",
  --   enabled = false,
  -- },
}
