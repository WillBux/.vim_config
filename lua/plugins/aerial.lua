return {
    "stevearc/aerial.nvim",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
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
    }
}
