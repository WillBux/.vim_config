return {
    "machakann/vim-sandwich",
    config = function()
        vim.g['sandwich#recipes'] = vim.deepcopy(vim.g['sandwich#default_recipes'])
    end
}
