return {
    'marko-cerovac/material.nvim',
    lazy = false,
    config = function(_, opts)
        vim.g.material_style = 'deep ocean'
        require('material').setup(opts)
        vim.cmd('colorscheme material')
        vim.cmd('set spell spelllang=en_us termguicolors')
    end,
    opts = {
        lualine_style = 'stealth',
        high_visibility = {
            darker = true,
        },
        custom_highlights = {
            SpellBad = {sp = "#F07178", undercurl=true},
            SpellCap = {sp = "#FFCB6B", undercurl=true},
            SpellRare = {sp = "#82AAFF", undercurl=true},
            SpellLocal = {sp = "#F78C6C", undercurl=true}
        },
        disable = {
            background = true,
        },
        plugins = {
            "nvim-tree",
            "telescope",
            "nvim-cmp",
            "indent-blankline",
            "gitsigns",
            "nvim-web-devicons",
            "which-key"
        }
    }
}

