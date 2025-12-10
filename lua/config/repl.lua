-- Create a terminal with a Python REPL that works as an interactive window
local function send_to_terminal(text)
  local term_buf = nil

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == 'terminal' then
      term_buf = buf
      break
    end
  end

  if not term_buf then
    vim.cmd 'split | terminal'
    term_buf = vim.api.nvim_get_current_buf()
    vim.cmd 'wincmd p'
  end
  local chan_id = vim.bo[term_buf].channel
  vim.api.nvim_chan_send(chan_id, text .. '\n')
end

vim.keymap.set('v', '<leader>r', function()
  local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'x', false)
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then
    return
  end
  if #lines == 1 then
    -- Single line selection - need to extract substring
    lines[1] = string.sub(lines[1], start_col, end_col)
  else
    -- Multi-line selection
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end
  local text = table.concat(lines, '\n')
  send_to_terminal(text)
end, { desc = 'Run selection in terminal' })

vim.keymap.set('n', '<leader>r', function()
  local line = vim.api.nvim_get_current_line()
  send_to_terminal(line)
end, { desc = 'Run line in terminal' })

vim.keymap.set('n', '<leader>pi', function()
  vim.cmd 'split | terminal source .venv/bin/activate && python'
end, { desc = 'Start interactive Python terminal' })
