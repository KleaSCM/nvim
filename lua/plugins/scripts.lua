local M = {}

-- Function to get list of scripts with categories
local function get_scripts()
    local scripts = {}
    local handle = io.popen('find Scripts -type f -name "*.sh"')
    if handle then
        for file in handle:lines() do
            -- Extract category and script name
            local category, script_name = file:match("Scripts/([^/]+)/(.*)%.sh$")
            if category and script_name then
                if not scripts[category] then
                    scripts[category] = {}
                end
                table.insert(scripts[category], script_name)
            end
        end
        handle:close()
    end
    return scripts
end

-- Function to create floating window
local function create_floating_window()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    -- Set buffer options
    vim.bo[buf].filetype = 'sh'
    vim.bo[buf].buftype = 'nofile'
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = true

    return buf, win
end

-- Function to execute a script
local function execute_script(category, script_name)
    local script_path = vim.fn.expand("~/.config/nvim/Scripts/" .. category .. "/" .. script_name .. ".sh")
    if vim.fn.filereadable(script_path) == 1 then
        vim.cmd("!chmod +x " .. script_path)
        
        -- Create floating window
        local buf, win = create_floating_window()
        
        -- Set window title
        vim.api.nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
        vim.api.nvim_win_set_option(win, 'winblend', 10)
        
        -- Execute script and capture output
        local output = vim.fn.system(script_path)
        local lines = vim.split(output, "\n")
        
        -- Add header
        table.insert(lines, 1, "Script: " .. script_name)
        table.insert(lines, 2, "Category: " .. category)
        table.insert(lines, 3, string.rep("─", 80))
        table.insert(lines, 4, "")
        
        -- Set lines in buffer
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        
        -- Make buffer read-only
        vim.bo[buf].modifiable = false
        
        -- Add keymaps for the floating window
        vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<cmd>close<CR>', { noremap = true, silent = true })
        
        -- Set cursor to top
        vim.api.nvim_win_set_cursor(win, {1, 0})
    else
        vim.notify("Script not found: " .. category .. "/" .. script_name, vim.log.levels.ERROR)
    end
end

-- Function to show category selection
local function show_category_prompt()
    local scripts = get_scripts()
    local categories = {}
    for category, _ in pairs(scripts) do
        table.insert(categories, category)
    end
    table.sort(categories)

    vim.ui.select(categories, {
        prompt = "Select category:",
        format_item = function(item)
            return "📁 " .. item
        end,
    }, function(category)
        if category then
            show_script_prompt(category, scripts[category])
        end
    end)
end

-- Function to show script selection
local function show_script_prompt(category, scripts)
    table.sort(scripts)
    vim.ui.select(scripts, {
        prompt = "Select script from " .. category .. ":",
        format_item = function(item)
            return "📜 " .. item
        end,
    }, function(script)
        if script then
            execute_script(category, script)
        end
    end)
end

-- Function to show script input prompt
function M.show_script_prompt()
    show_category_prompt()
end

-- Function to complete script names
function M.complete_scripts(_, cmd_line)
    local scripts = get_scripts()
    local matches = {}
    local cmd = cmd_line:match("%S+$") or ""
    
    for _, script in ipairs(scripts) do
        if script:lower():find(cmd:lower(), 1, true) then
            table.insert(matches, script)
        end
    end
    
    return matches
end

-- Setup function
function M.setup()
    -- Add keybinding to open script prompt
    vim.keymap.set('n', '<leader>s', M.show_script_prompt, { desc = "Run script" })
    
    -- Notify that the plugin is loaded
    vim.notify("Scripts plugin loaded", vim.log.levels.INFO)
end

return M 