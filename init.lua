return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  -- colorscheme = "astrodark",
  colorscheme = "tokyonight-night",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },

    config = {
      clangd = {
        cmd = {
          "D:/CodeBin/Qt/Tools/QtCreator/bin/clang/bin/clangd.exe",
          -- 主要标志
          "--compile-commands-dir=build/Debug/.qtc_clangd", -- 配置编译命令文件
          -- "--query-driver=D:/CodeBin/Qt/Tools/mingw1120_64/bin/gcc-*.exe,D:/CodeBin/Qt/Tools/mingw1120_64/bin/g++-*.exe",

          -- 功能
          "--all-scopes-completion", -- 全代码库补全
          "--background-index",
          "--background-index-priority=normal", -- 在后台自动分析代码
          "--clang-tidy", -- 格式化代码，目录下需要放一个.clang-format文件
          "--completion-style=bundled", -- (detailed or bundled)补全的方法时候显示参数，按tab下一项的那种
          "--fallback-style=WebKit", -- webkit microsoft gun都还不错(按喜好顺序排)
          "--header-insertion=iwyu", -- (iwyu or never)禁止头文件插入
          "--header-insertion-decorators", -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分

          -- clangd的性能
          "-j=16", -- 后台线程数，可根据机器配置自行调整
          "--pch-storage=memory", -- 用内存性能更好

          -- clangd信息
          "--log=error",
          "--pretty", -- 输出的 JSON 文件更美观
        },
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }

    -- close some filetypes with <q>
    vim.api.nvim_create_autocmd("FileType", {
      -- group = augroup("close_with_q"),
      pattern = {
        -- "PlenaryTestPopup",
        -- "help",
        -- "lspinfo",
        -- "man",
        -- "notify",
        -- "qf",
        -- "spectre_panel",
        -- "startuptime",
        -- "tsplayground",
        -- "neotest-output",
        -- "checkhealth",
        -- "neotest-summary",
        -- "neotest-output-panel",

        -- add
        "cmake_tools_terminal",
        "dap-repl",
        "dap-console",
        "dap-watches",
      },
      callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
      end,
    })

    -- remove comment when go to next line
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "*",
      },
      callback = function()
        -- 执行指令
        vim.cmd "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
      end,
    })
  end,
}
