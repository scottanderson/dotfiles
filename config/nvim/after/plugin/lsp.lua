local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'tsserver',
})

-- Fix undefined global 'vim'
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globasl = { 'vim' }
            }
        }
    }
})

lsp.configure('rust_analyzer', {
    settings = {
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
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
            diagnostics = { enable = false }
        }
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})
cmp_mappings['<CR>'] = nil
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = cmp.config.sources {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer', max_item_count = 5, keyword_length = 5 },
    },
})

---@diagnostic disable-next-line: unused-local
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local n_v = { 'n', 'v' }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<S-F6>', vim.lsp.buf.rename, opts)
    vim.keymap.set(n_v, '<leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set(n_v, '<leader><space>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>s', vim.lsp.buf.workspace_symbol, opts)
end)

-- Configure lua language server for neovim
lsp.nvim_workspace()

lsp.format_on_save({
    format_opts = {
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
    }
})

lsp.setup()
