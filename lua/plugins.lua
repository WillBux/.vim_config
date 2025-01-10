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
        "nvim-web-devicons",
        "which-key"
    }
})

vim.cmd 'colorscheme material'
vim.cmd 'set spell spelllang=en_us termguicolors'

-- tresitter
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = {"c", "cpp", "c_sharp", "lua", "python", "cmake", "markdown", "markdown_inline", "r", "regex", "vim", "make", "json", "svelte", "cooklang"},

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

require("aerial").setup({
    -- Priority list of preferred backends for aerial.
    backends = { "treesitter", "lsp", "markdown", "man" },

    -- A list of all symbols to display. Set to false to display all symbols.
    -- This can be a filetype map (see :help aerial-filetype-map)
    -- To see all available values, see :help SymbolKind
    filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
    },

    manage_folds = true,
    link_folds_to_tree = true,
    link_tree_to_folds = true,

    -- open in supported buffers
    open_automatic = true,

    -- Show box drawing characters for the tree hierarchy
    show_guides = false,

    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,

})

-- toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")


-- indent-backline
--vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")
require("ibl").setup {
    enabled = true,
    scope = {
    }
}

-- nvim-tree
require('nvim-tree').setup({
    --open_on_setup = true, -- auto open when opening a directory
    --open_on_setup_file = true, -- auto open when opening a file
    --open_on_tab = true,
    sort = {
        sorter = "filetype",
        folders_first = true,
        files_first = false,
    },
    filters = {
        dotfiles = false,
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
})

-- open nvim-tree when starting
vim.api.nvim_create_autocmd({ "VimEnter" }, { 
    callback = function(data)
        -- buffer is a real file on the disk
        local real_file = vim.fn.filereadable(data.file) == 1

        -- buffer is a [No Name]
        local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if directory then 
            error("directory")
            -- change to the directory
            vim.cmd.enew()

            -- wipe the directory buffer
            vim.cmd.bw(data.buf)

            -- change to the directory
            vim.cmd.cd(data.file)

            require("nvim-tree.api").tree.open()
            return
        elseif real_file or no_name then 
            -- open the tree, find the file but don't focus it
            require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
            return
        end

    end, 
})

local function tab_win_closed(winnr)
    local tabnr = vim.api.nvim_win_get_tabpage(winnr)
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buf_info = vim.fn.getbufinfo(bufnr)[1]
    local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
    local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
    if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
        -- Close all nvim tree on :q
        if not vim.tbl_isempty(tab_bufs) then        -- and was not the last window (not closed automatically by code below)
            api.tree.close()
        end
    else                                                    -- else closed buffer was normal buffer
        if #tab_bufs == 1 then                                -- if there is only 1 buffer left in the tab
            local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
            if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
                vim.schedule(function()
                    if #vim.api.nvim_list_wins() == 1 then          -- if its the last buffer in vim
                        vim.cmd "quit"                                -- then close all of vim
                    else                                            -- else there are more tabs open
                        vim.api.nvim_win_close(tab_wins[1], true)     -- then close only the tab
                    end
                end)
            end
        end
    end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})

vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<CR>")


-- gitsigns
require('gitsigns').setup()

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>lua require('telescope.builtin').commands()<cr>")

-- ALE
vim.g.ale_sign_error = '►'
vim.g.ale_sign_warning = '▻'
vim.g.ale_sign_column_always = 1
vim.api.nvim_create_autocmd('BufEnter', {pattern='*.lst', command = ":ALEDisable"})
-- Markdown
vim.g.mkdp_auto_start = 1
vim.g.mkdp_auto_close = 1
vim.g.mkdp_browser = '/Applications/Google Chrome.app'

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

-- which-key
vim.o.timeout = true
vim.o.timeoutlen = 150
require('which-key').setup({
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        }
    },
})
