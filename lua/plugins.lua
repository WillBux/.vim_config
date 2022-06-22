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

-- theme onedarkpro
local onedarkpro = require("onedarkpro")
onedarkpro.setup({
    theme = "onedark_dark", -- The default dark theme
    styles = {
        comments = "italic",
        functions = "NONE",
        keywords = "bold,italic",
        strings = "NONE",
        variables = "NONE",
        virtual_text = "NONE"
    }
})
onedarkpro.load()

local lualine = require('lualine')
lualine.setup()

-- tresitter
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",

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
}

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- auto close tree
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

-- ALE
vim.g.ale_sign_error = '►'
vim.g.ale_sign_warning = '▻'
vim.g.ale_sign_column_always = 1

-- Markdown
vim.g.mkdp_auto_start = 1

-- Sandwich
vim.g['sandwich#recipes'] = vim.deepcopy(vim.g['sandwich#default_recipes'])

