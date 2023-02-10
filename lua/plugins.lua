-- cash to speed up loading, should be loaded in first
_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_modpaths',
    }
}
require('impatient')

-- lualine theme
require('lualine').setup {
    options = {
        theme = 'material'
    }
}

-- theme material (deep ocean)
vim.g.material_style = "deep ocean"
require('material').setup({
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
        "nvim-web-devicons"
    }
})

vim.cmd 'colorscheme material'
vim.cmd 'set spell spelllang=en_us termguicolors'

-- tresitter
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = {"c", "cpp", "c_sharp", "lua", "python", "cmake", "markdown", "markdown_inline", "r", "regex", "vim", "make", "json"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {nil},

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {nil},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- indent-backline
--vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

-- nvim-tree
require'nvim-tree'.setup {
    open_on_setup = true, -- auto open when opening a directory
    open_on_setup_file = true, -- auto open when opening a file
    open_on_tab = true,
}

-- gitsigns
require('gitsigns').setup()

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- auto close tree
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")

-- ALE
vim.g.ale_sign_error = '►'
vim.g.ale_sign_warning = '▻'
vim.g.ale_sign_column_always = 1

-- Markdown
vim.g.mkdp_auto_start = 1

-- Sandwich
vim.g['sandwich#recipes'] = vim.deepcopy(vim.g['sandwich#default_recipes'])

-- Setup nvim_cmp
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['\t'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set 'select' to 'false' to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
    }, {
        { name = 'buffer' },
    })
})


-- Setup lspconfig
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.ccls.setup {
    capabilities = capabilities,
    init_options = {
        cache = {
            directory = ".ccls-cache";
        }
    }
}
lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}

-- vimtex
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_view_forward_search_on_start = false
vim.g.vimtex_toc_config = {
    mode = 1,
    fold_enable = 0,
    hide_line_numbers = 1,
    resize = 0,
    refresh_always = 1,
    show_help = 0,
    show_numbers = 1,
    split_pos = 'leftabove',
    split_width = 30,
    tocdeth = 3,
    indent_levels = 1,
    todo_sorted = 1,
}
