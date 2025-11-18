return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- LSP Support
        { 'williamboman/mason.nvim' },
        -- { 'williamboman/mason-lspconfig.nvim' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
-- Mason setup
require('mason').setup()

-- Mason LSP config
-- require('mason-lspconfig').setup({
--     ensure_installed = {
--         'eslint',
--         'lua_ls',
--         'rust_analyzer',
--         'ts_ls',
--     },
-- })

-- LSP configuration
local lspconfig = require('lspconfig')

-- common on_attach
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local n_v = { 'n', 'v' }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<S-F6>', vim.lsp.buf.rename, opts)
    vim.keymap.set(n_v, '<leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set(n_v, '<leader><space>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set('n', ']c', ':cn<cr>', opts)
    vim.keymap.set('n', '[c', ':cp<cr>', opts)
    vim.keymap.set('n', '<leader>s', vim.lsp.buf.workspace_symbol, opts)
end

-- Lua LS config
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- Rust Analyzer config
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
                allTargets = true,
            },
            check = {
                command = 'clippy',
                allFeatures = true,
                allTargets = true,
            },
            diagnostics = { enable = false },
        },
    },
})

-- TypeScript LS config
lspconfig.ts_ls.setup({ on_attach = on_attach })

-- ESLint config
lspconfig.eslint.setup({ on_attach = on_attach })

-- Completion
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})
cmp_mappings['<CR>'] = nil
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
cmp.setup({
    mapping = cmp_mappings,
    sources = cmp.config.sources {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer',  max_item_count = 5, keyword_length = 5 },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

---- Configure lua language server for neovim
--lsp.nvim_workspace()

---- Configure null-ls
--local null_ls = require("null-ls")
--null_ls.setup({
--    sources = {
--        null_ls.builtins.formatting.stylua,
--        null_ls.builtins.completion.spell,
--        -- require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
--    },
--})

--lsp.format_on_save({
--    format_opts = {
--        timeout_ms = 10000,
--    },
--    servers = {
--        ['lua_ls'] = { 'lua' },
--        ['rust_analyzer'] = { 'rust' },
--        ['null-ls'] = { 'markdown' },
--    }
--})

--lsp.setup()
    end
}
