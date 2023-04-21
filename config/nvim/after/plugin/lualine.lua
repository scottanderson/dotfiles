local colors = {
    red = 1,
    white = 231,
    yellow = 11,
    mediumorange = 166,
}

local function modified()
    local result = ''
    if vim.bo.modified then
        result = result .. '[+]'
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
        result = result .. '[-]'
    end
    return result

end

local function paste()
    local mode_code = vim.api.nvim_get_mode().mode
    if vim.o.paste == false or mode_code == 'n' or mode_code == 'c' then
        return ''
    end
    return 'PASTE'
end

require('lualine').setup {
    options = {
        theme = 'powerline',
    },
    sections = {
        lualine_a = {
            'mode',
            { paste, color = { bg = colors.mediumorange, fg = colors.white, gui = 'bold' } },
        },
        lualine_b = {
            'branch',
        },
        lualine_c = {
            { 'filename', file_status = false },
            { modified, color = { fg = colors.yellow } },
            {
                'diagnostics',
                source = { 'nvim' },
                sections = { 'error' },
                diagnostics_color = { error = { fg = colors.red } },
            },
            {
                'diagnostics',
                source = { 'nvim' },
                sections = { 'warn' },
                diagnostics_color = { warn = { fg = colors.yellow } },
            },
        },
    },
}
