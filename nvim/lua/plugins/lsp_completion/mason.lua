-- ================================================================================
-- =                                  MASON.NVIM                                  =
-- ================================================================================

return {
    "williamboman/mason.nvim",
    -- enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- Mason
        require("mason").setup({
            ui = {
                border = "rounded",
                backdrop = 100,
            },
        })

        -- Mason lsp config
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", -- lua ls
                "basedpyright", -- python ls
                -- "ty", -- python lsp
                -- "pyrefly", -- python ls
                "bashls", -- bash ls
                "powershell_es", -- powershell ls (includes formatter and linter)
                "html", -- html ls
                "cssls", -- css ls
                "phpantom_lsp", -- php ls
                "vtsls", -- ts/js ls
                "markdown_oxide", --md ls
            },
            automatic_enable = true,
        })

        -- Custom tool installation using Mason registry directly
        -- mason-tool-installer.nvim added too much startup time
        local tools = {
            "luacheck", -- lua linter
            "stylua", -- lua formatter
            "ruff", -- python linter/formatter
            "shellcheck", -- bash linter
            "shfmt", -- bash formatter
            "htmlhint", -- html linter
            "prettier", -- js, ts, css, html, yaml etc formatter
            "djlint", -- html linter/formatter designed for django
            "sqruff", -- sql linter/formatter
            "biome", -- js, ts, jsx, json, css linter/formatter
            "dprint", -- md formatter
        }

        local registry = require("mason-registry")
        registry.refresh(function()
            for _, name in ipairs(tools) do
                if not registry.is_installed(name) then
                    local package = registry.get_package(name)

                    vim.notify(name .. ": installing", vim.log.levels.INFO)

                    package:install():once("closed", function()
                        if package:is_installed() then
                            vim.notify(name .. ": successfully installed", vim.log.levels.INFO)
                        else
                            vim.notify(name .. ": installation failed", vim.log.levels.ERROR)
                        end
                    end)
                end
            end
        end)
    end,
}
