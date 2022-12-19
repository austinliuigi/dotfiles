-- Print lua table
-- @param table Table to print
P = function(table)
  print(vim.inspect(table))
  return table
end



-- Return highlight color (hex or color name) of a given group's attribute
-- @param group Name of highlight group
-- @param attribute 'foreground' | 'background'
GetHiVal = function (group, attribute)
  return string.format("#%06x", vim.api.nvim_get_hl_by_name(group, true)[attribute])
end



-- Copy output of command into given register
-- If no registers are given, use default ones
vim.api.nvim_create_user_command("Cp", function(args)
  local fargs = args.fargs

  -- Register passed in as arg (including quote); nil if none provided
  local provided_reg = string.match(fargs[#fargs], '".')

  -- If a register was explicity given
  if provided_reg ~= nil then
    -- Remove last element in fargs (provided register) and set the last char to reg
    local reg = string.sub(table.remove(fargs), -1, -1)
    -- Redirect output of command to given register
    vim.cmd('redir @' .. reg .. ' | execute ' .. table.concat(args.fargs, " ") .. ' | redir END')
  else
    -- Mapping from 'clipboard' option to register names
    local clip_to_reg = { unnamed = "*", unnamedplus = "+" }
    -- Redirect output of command to default register
    vim.cmd('redir @" | execute ' .. table.concat(args.fargs, " ") .. ' | redir END')
    -- For each register in 'clipboard'
    for _, opt in ipairs(vim.opt.clipboard:get()) do
      -- Copy contents of default register into reg
      vim.cmd("let @" .. clip_to_reg[opt] .. '=@"')
    end
  end
end, { nargs = "+" })

vim.api.nvim_create_user_command("Cp", function(args)
  vim.cmd("tcd %:t")
end, { nargs = 0 })
