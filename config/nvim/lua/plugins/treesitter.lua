return {
    {
        'romus204/tree-sitter-manager.nvim',
        branch = 'develop',
        opts = {
            ensure_installed = { -- parsers to install at startup
                'c',
                'javascript',
                'lua',
                'rust',
                'typescript',
                'vimdoc',
            },
            auto_install = true, -- auto-install when a new filetype is encountered
        },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
            max_lines = 20,       -- How many lines the window should span. Values <= 0 mean no limit.
            trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'topline',     -- Line used to calculate context. Choices: 'cursor', 'topline'
        },
config = function()
vim.keymap.set('n', '<leader>c', '<Cmd>TSContext toggle<CR>', {})
end
    },
    -- { 'nvim-treesitter/playground' },
}
