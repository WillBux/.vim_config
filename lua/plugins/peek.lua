return {
    "toppair/peek.nvim",
    event = "VeryLazy",
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        vim.api.nvim_create_user_command("PeakToggle", 
        function()
            if require("peek").is_open() then
                require("peek").close()
            else
                require("peek").open()
            end
        end, { nargs = '?'})
    end,
}
