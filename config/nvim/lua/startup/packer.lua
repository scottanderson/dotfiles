-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Install plugins
return packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use { 'ThePrimeagen/harpoon' }
    use { 'ThePrimeagen/refactoring.nvim' }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
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
        }
    }
    use { 'christoomey/vim-tmux-navigator' }
    use { 'folke/trouble.nvim', requires = 'nvim-tree/nvim-web-devicons' }
    use { 'mbbill/undotree' }
    use { 'nvim-lualine/lualine.nvim' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = 'nvim-lua/plenary.nvim' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context' }
    use { 'nvim-treesitter/playground' }
    use { 'preservim/vim-indent-guides' }
    use { 'tomasiser/vim-code-dark' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-fugitive' }
    use {
        'utilyre/barbecue.nvim',
        tag = '*',
        requires = { 'SmiteshP/nvim-navic' },
        config = function()
            require('barbecue').setup()
        end,
    }
    use { 'windwp/nvim-autopairs' }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
