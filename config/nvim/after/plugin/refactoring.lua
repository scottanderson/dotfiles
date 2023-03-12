require('refactoring').setup({})

local function refactor_map(mode, lhs, refactor)
    local options = { noremap = true, silent = true, expr = false }
    local rhs = ([[<Esc><Cmd>lua require('refactoring').refactor('%s')<CR>]]):format(refactor)
    vim.keymap.set(mode, lhs, rhs, options)
end

-- remap to open the Telescope refactoring menu in visual mode
require('telescope').load_extension('refactoring')
local noremap = { noremap = true }
vim.keymap.set('v', '<leader>rr', [[<Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], noremap)

-- Remaps for the refactoring operations currently offered by the plugin
refactor_map('v', '<leader>re', 'Extract Function')
refactor_map('v', '<leader>rf', 'Extract Function To File')
refactor_map('v', '<leader>rv', 'Extract Variable')
refactor_map({ 'n', 'v' }, '<leader>i', 'Inline Variable')
refactor_map('n', '<leader>rb', 'Extract Block')
refactor_map('n', '<leader>rbf', 'Extract Block To File')
