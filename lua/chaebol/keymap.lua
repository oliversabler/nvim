-- Move line(s) up/down
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")

-- Page up/down and center
vim.keymap.set("n", "<C-k>", "<C-u>zz")
vim.keymap.set("n", "<C-j>", "<C-d>zz")

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

local function trim_leading_whitespace(text)
  local lines = vim.split(text, "\n", { trimempty = false })

  if #lines > 0 and lines[#lines] == "" then
    table.remove(lines)
  end

  if #lines == 1 then
    return lines[1]:match("^%s*(.*)$") .. "\n"
  end

  local min_indent = math.huge
  for _, line in ipairs(lines) do
    if line ~= "" then
      min_indent = math.min(min_indent, #line:match("^%s*"))
    end
  end

  if min_indent > 0 and min_indent < math.huge then
    for i, line in ipairs(lines) do
      if line ~= "" then
        lines[i] = line:sub(min_indent + 1)
      end
    end
  end

  return table.concat(lines, "\n") .. "\n"
end

-- Copy to clipboard and trim leading whitespace
vim.keymap.set("v", "<leader>c", function()
  vim.cmd('normal! "+y')
  vim.fn.setreg("+", trim_leading_whitespace(vim.fn.getreg("+")))
end)
