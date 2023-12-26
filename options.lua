return {
  opt = {
    relativenumber = true, -- 相对行号
    number = true, -- 行号
    spell = false, -- 单词拼写
    signcolumn = "yes", -- 行号行固定
    wrap = true, -- 超出屏幕宽度折行

    -- tab use space
    expandtab = true, -- 使用空格代替tab
    shiftwidth = 4, -- 每个tab操作的空格数量，非tab键操作
    autoindent = true, -- 新行用当前行的缩进
    tabstop = 4, -- 每个tab键的空格数量

    showcmdloc = "statusline",
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    resession_enabled = false, -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
