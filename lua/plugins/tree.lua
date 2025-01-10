return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons', 
    },
    config = function(_, opts)
        require('nvim-tree').setup(opts)
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
                    require("nvim-tree.api").tree.close()
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
    end,
    opts = {
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
    },
}
