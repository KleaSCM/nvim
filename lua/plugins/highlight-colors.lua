return {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        render = 'background', -- or 'foreground' or 'first_column'
        enable_named_colors = true,
        enable_tailwind = true,
        custom_colors = {
            -- Define custom colors here
            -- { label = "%-%-theme%-font%-color", color = "#fff" },
        }
    },
} 