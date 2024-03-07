-- 这个是neovide的设置

if vim.fn.has("win32") == 1 then
    -- 在Windows上运行的代码
    vim.o.guifont = "Maple Mono SC NF:h13"
elseif vim.fn.has("unix") == 1 then
    -- 在Unix-like系统（包括Linux和macOS）上运行的代码
    if vim.fn.has("macunix") == 1 then
        -- 在macOS上运行的代码
    else
        -- 在Linux上运行的代码
        vim.o.guifont = "Maple Mono SC NF:h13"
    end
else
    -- 在其他操作系统上运行的代码
    print("This is an unsupported operating system.")
end

-- 将 g:neovide_no_idle 设置为布尔值将强制 Neovide 始终重绘。如果动画似乎停止得太早，这可能是一个快速解决方案。
vim.g.neovide_no_idle = true
-- 退出确认
vim.g.neovide_confirm_quit = true
-- 全屏(没有任务栏的那种)
vim.g.neovide_fullscreen = false
-- 记住窗口大小
vim.g.neovide_remember_window_size = true
-- 没有焦点的时候的刷新率
vim.g.neovide_refresh_rate_idle = 5
-- 普通刷新率
vim.g.neovide_refresh_rate = 60
-- 滚动动画的时间
vim.g.neovide_scroll_animation_length = 0.3

return {}
