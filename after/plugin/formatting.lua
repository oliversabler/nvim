local filetypes = { "javascript", "typescript" }
local formatters = {}
for _, filetype in ipairs(filetypes) do
    formatters[filetype] = { "prettier" }
end

require("conform").setup({
    formatters_by_ft = formatters,
    formatters = {
        -- Only format projects with a Prettier config (including package.json).
        prettier = { require_cwd = true },
    },
    format_on_save = function(bufnr)
        if not vim.tbl_contains(filetypes, vim.bo[bufnr].filetype) then return end

        -- Apply ESLint fixes before Prettier formatting.
        if #vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" }) > 0 then
            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("LspEslintFixAll")
            end)
        end

        return { timeout_ms = 3000, lsp_format = "never" }
    end,
})
