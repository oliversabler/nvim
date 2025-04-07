local statuscolumn = {}

function statuscolumn.Set()
    local rel_num = vim.v.relnum
    local abs_num = vim.v.lnum
    local bufnr = vim.api.nvim_get_current_buf()

--    local diags = vim.diagnostic.get(bufnr, { lnum = abs_num - 1 })
--    local symbol = '  '
--
--    if #diags > 0 then
--        table.sort(diags, function(a, b)
--            return a.severity < b.severity
--        end)
--
--        local top_diag = diags[1]
--        local config = vim.diagnostic.config()
--        local signs = config.signs
--
--        if type(signs) == "table" and signs.text then
--            local icon = signs.text[top_diag.severity]
--            if icon then
--                symbol = icon .. ' '
--            end
--        end
--    end
--
--    local dap_symbols = vim.fn.sign_getplaced(bufnr, {
--        group = '*',
--        lnum = abs_num,
--    })[1].signs
--
--    if #dap_symbols > 0 then
--        for _, sign in ipairs(dap_symbols) do
--            if sign.name:match("DapBreakpoint") then
--              symbol = '● '
--              break
--            elseif sign.name:match("DapStopped") then
--              symbol = '▶ '
--              break
--          end
--        end
--    end

    local symbol = statuscolumn.set_diagnostic_symbol(abs_num, bufnr)
    local signs = statuscolumn.get_signs(abs_num, bufnr)

    if #signs > 0 then
        symbol = statuscolumn.set_dap_symbol(symbol, signs)
    end

    local rel_str = string.format('%3d', rel_num)
    local abs_str = string.format('%3d', abs_num)

    return string.format('%s%s %s', abs_str, rel_str, symbol)
end

function statuscolumn.set_diagnostic_symbol(abs_num, bufnr)
    local diags = vim.diagnostic.get(bufnr, { lnum = abs_num - 1 })

    if #diags > 0 then
        table.sort(diags, function(a, b)
            return a.severity < b.severity
        end)

        local top_diag = diags[1]
        local config = vim.diagnostic.config()
        local signs = config.signs

        if type(signs) == "table" and signs.text then
            local icon = signs.text[top_diag.severity]
            if icon then
                return icon .. ' '
            end
        end
    end

    return '  '
end

function statuscolumn.get_signs(abs_num, bufnr)
    return vim.fn.sign_getplaced(bufnr, {
        group = '*',
        lnum = abs_num,
    })[1].signs
end

function statuscolumn.set_dap_symbol(symbol, signs)
    for _, sign in ipairs(signs) do
        if sign.name:match("DapBreakpoint") then
            symbol = '● '
            break
        elseif sign.name:match("DapStopped") then
            symbol = '▶ '
            break
        end
    end
    return symbol
end

return statuscolumn
