-- 目录管理

-- 配合所有会话恢复管理插件
-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--   pattern = 'NvimTree*',
--   callback = function()
--     local api = require('nvim-tree.api')
--     local view = require('nvim-tree.view')
--
--     if not view.is_visible() then
--       api.tree.open()
--     end
--   end,
-- })

local E_root = vim.loop.cwd()
local e_root = vim.loop.cwd()

-- 动态变化根目录
-- local function get_e_root()
--     local now_file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h')
--     -- print("e_root:", e_root)
--     -- print("E_root:", E_root)
--     -- print("now_file_path:", now_file_path)
--
--     if string.sub(now_file_path, 1, string.len(e_root)) == e_root then
--         -- print("is e_root")
--         return e_root
--     elseif string.sub(now_file_path, 1, string.len(E_root)) == E_root then
--         -- print("is E_root")
--         return E_root
--     else
--         -- print("is now_file_path")
--         e_root = now_file_path
--         return now_file_path
--     end
-- end

local function is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory"
end

local function is_file(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
end

local function get_parent_directory(path)
  local parts = {}
  for part in path:gmatch "[^/\\]+" do
    table.insert(parts, part)
  end
  table.remove(parts)
  return table.concat(parts, "/")
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", ".", function()
    local node = api.tree.get_node_under_cursor()
    if not node.absolute_path then
      if node.name == ".." then
        local now_directory = api.tree.get_nodes().absolute_path
        vim.cmd("cd " .. now_directory)
        e_root = now_directory
        vim.notify("[info] nvim-tree_lua.lua: change root to " .. now_directory, vim.log.levels.INFO)
      else
        vim.notify("[error] nvim-tree_lua.lua: the node is not a directory or file)", vim.log.levels.ERROR)
      end
      return
    end
    local path = node.absolute_path

    if is_directory(path) then
      vim.cmd("cd " .. path)
      e_root = path
    elseif is_file(path) then
      local parent_directory = get_parent_directory(path)
      vim.cmd("cd " .. parent_directory)
      e_root = parent_directory
    else
      vim.notify("[error] nvim-tree_lua.lua: " .. path .. " is not a directory or file)", vim.log.levels.ERROR)
    end
    api.tree.change_root(e_root)
    vim.notify("[info] nvim-tree_lua.lua: change root to " .. e_root, vim.log.levels.INFO)
  end, opts "set root dir")

  vim.keymap.set("n", "g?", function()
    api.tree.toggle_help()
    vim.cmd "resize 30"
  end, opts "Help")
end

return {
  "nvim-tree/nvim-tree.lua",
  -- event = "BufEnter",
  lazy = false,
  version = "*",
  enabled = true,
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
  keys = {
    {
      "<leader>e",
      function() require("nvim-tree.api").tree.toggle { path = e_root } end,
      desc = "open current file",
    },
    {
      "<leader>E",
      function() require("nvim-tree.api").tree.toggle { path = E_root } end,
      desc = "open current root",
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  },
  opts = {
    on_attach = my_on_attach,
    view = {
      -- 宽度
      width = 30,
      -- 行号
      number = false,
      -- 相对行号
      relativenumber = false,
    },
    renderer = {
      -- git高亮
      highlight_git = true,
      indent_markers = {
        -- 启动线显示
        enable = true,
      },
    },
    update_focused_file = {
      -- 启动时显示当前文件
      enable = true,
    },
    diagnostics = {
      -- 显示诊断信息
      enable = true,
    },
    modified = {
      -- 显示修改标记
      enable = true,
    },
    filters = {
      git_ignored = false,
    },
  },
}
