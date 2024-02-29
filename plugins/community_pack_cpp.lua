-- aeff33f

local utils = require "astronvim.utils"
local prefix = "<leader>lc"
local Path = require "plenary.path"
utils.set_mappings { n = { [prefix] = { desc = "cpp" } } }
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "cpp", "c", "objc", "cuda", "proto" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "clangd") end,
  },
  {
    "p00f/clangd_extensions.nvim",
    init = function()
      -- load clangd extensions when clangd attaches
      local augroup = vim.api.nvim_create_augroup("clangd_extensions", { clear = true })
      vim.keymap.set("n", "<leader>lcc", "<Cmd>ClangdSwitchSourceHeader<CR>", { desc = "ClangdSwitchSourceHeader" })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
            require "clangd_extensions"
            vim.api.nvim_del_augroup_by_id(augroup)
          end
        end,
      })
    end,
  },
  -- {
  --   "Civitasv/cmake-tools.nvim",
  --   ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  --   dependencies = {
  --     {
  --       "jay-babu/mason-nvim-dap.nvim",
  --       opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "codelldb") end,
  --     },
  --   },
  --   -- 每一个项目都会有一个会话备份，如果打开过的项目，需要清除会话备份，才会重新启动新的默认配置
  --   -- 参考：https://github.com/Civitasv/cmake-tools.nvim/blob/master/docs/sessions.md
  --   -- unix and mac: ~/.cache/cmake_tools_nvim/
  --   -- windows: ~/AppData/cmake_tools_nvim/
  --   opts = {
  --     cmake_regenerate_on_save = false,
  --     cmake_build_directory = "build\\${variant:buildType}",
  --
  --     -- 在vscode中的qt项目，使用cmake默认的构建参数，用来参考，请勿在CMakeLists.txt中尝试配置编译器
  --     -- D:\CodeBin\mingw64\bin\cmake.EXE
  --     -- --no-warn-unused-cli
  --     -- -DCMAKE_BUILD_TYPE:STRING=Debug
  --     -- -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE
  --     -- -DCMAKE_C_COMPILER:FILEPATH=D:\CodeBin\Qt\Tools\mingw1120_64\bin\gcc.exe
  --     -- -DCMAKE_CXX_COMPILER:FILEPATH=D:\CodeBin\Qt\Tools\mingw1120_64\bin\g++.exe
  --     -- -SD:/CodeData/cpp/Chess_game_QT
  --     -- -Bd:/CodeData/cpp/Chess_game_QT/build
  --     -- -G "MinGW Makefiles"
  --     cmake_generate_options = {
  --       "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
  --       "-DCMAKE_C_COMPILER:FILEPATH=D:/CodeBin/Qt/Tools/mingw1120_64/bin/gcc.exe",
  --       "-DCMAKE_CXX_COMPILER:FILEPATH=D:/CodeBin/Qt/Tools/mingw1120_64/bin/g++.exe",
  --       "-DCMAKE_BUILD_TYPE:STRING=Debug",
  --     },
  --   },
  -- },

  {
    "Shatur/neovim-tasks",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
          opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "codelldb", "cppdbg" })
        end,
      },
    },
    init = function()
      vim.keymap.set("n", "<leader>lcd", "<Cmd>Task start cmake debug<CR>", { desc = "cpp debug" })
      vim.keymap.set("n", "<leader>lcr", "<Cmd>Task start cmake run<CR>", { desc = "cpp run" })
      vim.keymap.set("n", "<leader>lcg", "<Cmd>Task start cmake configure<CR>", { desc = "cpp config" })
      vim.keymap.set("n", "<leader>lcb", "<Cmd>Task start cmake build<CR>", { desc = "cpp build" })
      vim.keymap.set("n", "<leader>lct", "<Cmd>Task set_module_param cmake target<CR>", { desc = "cpp set target" })
    end,
    -- opts = function(_, opts)
    --   vim.keymap.set("n", "<leader>lcd", "<Cmd>CMakeDebug<CR>", { desc = "cpp debug" })
    --   vim.keymap.set("n", "<leader>lcr", "<Cmd>CMakeRun<CR>", { desc = "cpp run" })
    --   opts.default_params.cmake.args.configure = {
    --     "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
    --     "-DCMAKE_C_COMPILER:FILEPATH=D:/CodeBin/Qt/Tools/mingw1120_64/bin/gcc.exe",
    --     "-DCMAKE_CXX_COMPILER:FILEPATH=D:/CodeBin/Qt/Tools/mingw1120_64/bin/g++.exe",
    --     "-DCMAKE_BUILD_TYPE:STRING=Debug",
    --   }
    --   return opts
    -- end,
    opts = {
      default_params = {
        cmake = {
          build_dir = tostring(Path:new("{cwd}", "build", "{build_type}")), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
          -- dap_name = "codelldb",

          -- qt的标配
          dap_name = "cppdbg",
          args = {
            configure = {
              "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
              "-DCMAKE_C_COMPILER:FILEPATH=D:/CodeBin/Qt/Tools/mingw1120_64/bin/gcc.exe",
              "-DCMAKE_CXX_COMPILER:FILEPATH=D:/CodeBin/Qt/Tools/mingw1120_64/bin/g++.exe",
              "-DCMAKE_BUILD_TYPE:STRING=Debug",
              "-G MinGW Makefiles",
            },
          },
        },
      },
      save_before_run = false, -- If true, all files will be saved before executing a task.
      params_file = tostring(Path:new("build", "neovim.json")), -- JSON file to store module and task parameters.
      dap_open_command = function() end,
    },
  },
}
