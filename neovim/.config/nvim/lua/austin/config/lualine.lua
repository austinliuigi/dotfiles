-- local function cwd()
--   return vim.fn.substitute(vim.fn.getcwd(), vim.env.HOME, '~', '')
-- end

local function cwd()
  return string.gsub(vim.fn.getcwd(), vim.env.HOME, '~')
end

local function truncwd(trunc_width)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if trunc_width and win_width < trunc_width then
      return vim.fn.pathshorten(str)
    end
    return str
  end
end

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {{'mode', fmt=trunc(80, 1, nil, false), color={gui='bold'}}},
    lualine_b = {'branch'},
    lualine_c = {'%=', { cwd, fmt=truncwd(80) }},
    -- lualine_c = {'%=', { cwd, fmt=truncwd(80), color=function() return vim.o.modified and {fg = '#db4b4b'} or nil end }},
    lualine_x = {'fileformat'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
