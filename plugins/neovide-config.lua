-- 这个是neovide的设置

if vim.fn.has("win32") == 1 then
    -- 在Windows上运行的代码
    vim.o.guifont = "Maple Mono SC NF:h13"
    vim.g.neovide_scroll_animation_length = 1
elseif vim.fn.has("unix") == 1 then
    -- 在Unix-like系统（包括Linux和macOS）上运行的代码
    if vim.fn.has("macunix") == 1 then
        -- 在macOS上运行的代码
    else
        -- 在Linux上运行的代码
        vim.o.guifont = "Maple Mono SC NF:h18"
        vim.g.neovide_scroll_animation_length = 1
    end
else
    -- 在其他操作系统上运行的代码
    print("This is an unsupported operating system.")
end

return {}
