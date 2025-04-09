local statuscolumn = {}

local function get_sign(abs_num, bufnr)
    local dap_signs = {
        DapBreakpoint = "●",
        DapStopped = "▶",
    }

    local signs = vim.fn.sign_getplaced(bufnr, {
        group = "*",
        lnum = abs_num,
    })[1].signs

    for _, sign in ipairs(signs) do
        for prefix, symbol in pairs(dap_signs) do
            if sign.name:match(prefix) then
                return symbol
            end
        end
    end

    local diags = vim.diagnostic.get(bufnr, { lnum = abs_num - 1 })

    if #diags > 0 then
        table.sort(diags, function(a, b)
            return a.severity < b.severity
        end)

        local top_diag = diags[1]
        local icon = vim.diagnostic.config().signs.text[top_diag.severity]
        if icon then
            return icon .. " "
        end
    end

    return " "
end

function statuscolumn.Set()
    local rel_num = vim.v.relnum
    local abs_num = vim.v.lnum

    local bufnr = vim.api.nvim_get_current_buf()
    local sign = get_sign(abs_num, bufnr)

    local rel_str = string.format("%3d", rel_num)
    local abs_str = string.format("%3d", abs_num)
    local sign_str = string.format("%2s", sign)

    return string.format("%s%s %s", abs_str, rel_str, sign_str)
end

return statuscolumn
