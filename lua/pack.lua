-- All plugins via packer
return require('packer').startup(function(use)
    
    -- Theme
    use 'olimorris/onedarkpro.nvim'

    -- tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- Completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Ultisnips
    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'

    -- tab tracker
    use 'lukas-reineke/indent-blankline.nvim'

    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    
    -- GitHub Copilot
    use 'github/copilot.vim'
    
    -- Tree 
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', 
        },
        tag = 'nightly' 
    }

    -- telescope
    -- brew install ripgrep // for speed
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- ALE
    use 'dense-analysis/ale'

    -- Sandwich
    use 'machakann/vim-sandwich'

    -- signify -- diff for git
    use 'mhinz/vim-signify'

    -- markdown
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- cash to speed up loading
    use 'lewis6991/impatient.nvim'

    -- Packer self-manage
    use 'wbthomason/packer.nvim'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
