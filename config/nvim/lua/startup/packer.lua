vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
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
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = 'nvim-lua/plenary.nvim' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-context' }
    use { 'nvim-treesitter/playground' }
    use { 'preservim/vim-indent-guides' }
    use { 'tomasiser/vim-code-dark' }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-fugitive' }
    use { 'windwp/nvim-autopairs' }
end)
