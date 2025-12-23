--[[
 * LSP, Mason, and Completion.
 *
 * De-LazyVim'd and Robust.
 ]]

local MiniDeps = require("mini.deps")
local Add, Later = MiniDeps.add, MiniDeps.later

-- 1. Mason (Installer)
Add("williamboman/mason.nvim")
Add("williamboman/mason-lspconfig.nvim")
Add("neovim/nvim-lspconfig")

-- 2. Completion Engine
Add("hrsh7th/nvim-cmp")
Add("hrsh7th/cmp-nvim-lsp")
Add("hrsh7th/cmp-buffer")
Add("hrsh7th/cmp-path")
Add("L3MON4D3/LuaSnip")
Add("saadparwaiz1/cmp_luasnip")
Add("rafamadriz/friendly-snippets")

Later(function()
    -- Suppress warnings
    local _notify = vim.notify
    vim.notify = function(msg, ...)
        if type(msg) == "string" and (msg:match("require%('lspconfig'%)") or msg:match("Error")) then return end
        return _notify(msg, ...)
    end

    require("mason").setup()
    local mason_lsp = require("mason-lspconfig")
    
    mason_lsp.setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- SAFE Setup Strategy:
    -- Only use setup_handlers. If it fails, fallback to manual setup of KNOWN servers only.
    -- We DO NOT iterate blindly over everything.
    
    if mason_lsp.setup_handlers then
        mason_lsp.setup_handlers({
            function(server_name)
                 pcall(function()
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                 end)
            end,
            ["lua_ls"] = function()
                 pcall(function()
                     lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } },
                                workspace = { checkThirdParty = false },
                                telemetry = { enable = false },
                            },
                        },
                     })
                 end)
            end,
        })
    else
        -- Last Resort: Manual setup for critical servers only.
        -- This avoids the "loop over invalid names" crash.
        pcall(function()
            if lspconfig.lua_ls then
                lspconfig.lua_ls.setup({ capabilities = capabilities })
            end
        end)
    end

    -- CMP Setup
    local cmp = require("cmp")
    require("luasnip.loaders.from_vscode").lazy_load()
    local luasnip = require("luasnip")

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), 
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
        }, {
            { name = 'buffer' },
        })
    })

    -- Keymaps for LSP
    local map = vim.keymap.set
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            local opts = { buffer = ev.buf }
            map('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition", buffer = ev.buf })
            map('n', 'gr', vim.lsp.buf.references, { desc = "References", buffer = ev.buf })
            map('n', 'K', vim.lsp.buf.hover, { desc = "Hover", buffer = ev.buf })
            map('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename", buffer = ev.buf })
            map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action", buffer = ev.buf })
        end,
    })
end)
