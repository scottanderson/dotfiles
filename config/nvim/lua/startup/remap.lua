vim.g.mapleader = '\\'

local silent = { silent = true }
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Disable arrow keys
map('n', '<Left>', '<Nop>')
map('n', '<Down>', ':move .1:<CR>==', silent)
map('n', '<Up>', ':move .-2:<CR>==', silent)
map('n', '<Right>', '<Nop>')
map('i', '<Left>', '<Nop>')
map('i', '<Down>', '<Nop>')
map('i', '<Up>', '<Nop>')
map('i', '<Right>', '<Nop>')
map('v', '<Left>', '<Nop>')
map('v', '<Down>', ":move '>+1<CR>gv=gv")
map('v', '<Up>', ":move '<-2<CR>gv=gv")
map('v', '<Right>', '<Nop>')

--  Insert mode movement
map('i', '<C-h>', '<Left>')
map('i', '<C-j>', '<Down>')
map('i', '<C-k>', '<Up>')
map('i', '<C-l>', '<Right>')

-- Modify cursor behavior for paging
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Quick toggles inspired by tpope/vim-unimpaired
local function option_map(letter, option, mode)
    local lhs = 'co' .. letter
    local rhs = string.format(':%s %s! %s?<CR>', mode, option, option)
    local options = silent
    map('n', lhs, rhs, options)
end
local function option_tgl(letter, option, active, inactive)
    local lhs = 'co' .. letter
    local rhs = function()
        if vim.o[option] == active then
            vim.o[option] = inactive
        else
            vim.o[option] = active
        end
        vim.cmd(string.format(':set %s?', option))
    end
    local options = silent
    map('n', lhs, rhs, options)
end
option_map('c', 'cursorline', 'setlocal')
option_map('u', 'cursorcolumn', 'setlocal')
option_map('i', 'ignorecase', 'set')
option_map('h', 'hlsearch', 'set')
option_map('l', 'list', 'setlocal')
option_map('n', 'number', 'setlocal')
option_map('r', 'relativenumber', 'setlocal')
option_map('s', 'spell', 'setlocal')
option_map('w', 'wrap', 'setlocal')
option_tgl('f', 'signcolumn', 'number', 'no')
map('n', 'cot', ':TSContextToggle<CR>', silent)
map('n', ']b', ':bn<CR>', silent)
map('n', '[b', ':bp<CR>', silent)

-- Do not add these motions to the jump list
map('n', '{', ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>', silent)
map('n', '}', ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>', silent)

map('n', '<leader><leader>', ':so %<CR>')
map('n', '<leader>.', '<Nop>')
map('n', '<leader>e', ':Ex<CR>')
map('n', '<C-e>', '<cmd>TroubleToggle<CR>')
