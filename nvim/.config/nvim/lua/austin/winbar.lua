-- Set winbar highlights after changing colorschemes
vim.api.nvim_create_augroup("WinbarHighlights", {clear = true})
vim.api.nvim_create_autocmd("ColorScheme", {
  group   = "WinbarHighlights",
  pattern = {'*'},
  command = 'lua require("austin.winbar"):set_highlights()',
})


local M = {}

M.trunc_width     = 80
M.readonly_icon   = ""
M.modified_icon   = "●"
M.centerside_left_edge_icon  = ""
M.centerside_right_edge_icon = ""
M.leftside_left_edge_icon  = { normal = "", truncated =  "" }
M.leftside_right_edge_icon = { normal = "", truncated =  "█" }
M.filepath_type   = "tail" -- "tail" | "rel" | "abs"



--[[ Highlighting ]]

-- Relevant winbar colors
M.colors = function()
  local colors =  {
    centerside_background = GetHiVal("Comment", "foreground"),
    leftside_background   = GetHiVal("TabLine", "background"),
    shroom                = GetHiVal("Comment", "foreground"),
    filepath              = GetHiVal("Normal",  "foreground"),
    readonly              = "lightblue",
    modified              = "lightpink", -- "#db4b4b",
  }
  return colors
end

-- Winbar highlights: key = hl_group name, val = hl_attribute table
M.highlights = function(self)
  local colors = self.colors()
  local highlights = {
    WinbarShroom                  = { fg = colors.leftside_background,   bg = colors.shroom,                reverse = true},
    WinbarLeftsideEdge            = { fg = colors.leftside_background,   bg = "NONE",                       },
    WinbarFilepath                = { fg = colors.filepath,              bg = colors.centerside_background, },
    WinbarReadonly                = { fg = colors.readonly,              bg = colors.centerside_background, },
    WinbarModified                = { fg = colors.modified,              bg = colors.centerside_background, },
    WinbarFilepathModified        = { fg = colors.filepath,              bg = colors.centerside_background, italic = true},
    WinbarCentersideEdge          = { fg = colors.centerside_background, bg = "NONE",                       },
    WinbarCentersideLeftEdgeTrunc = { fg = colors.centerside_background, bg = colors.leftside_background,   },
    WinbarNavic                   = { fg = colors.centerside_background, bg = "NONE",                       },
    NavicText                     = { fg = colors.centerside_background, },
    NavicSeparator                = { fg = colors.centerside_background, },
  }
  return highlights
end
-- Define winbar highlights
M.set_highlights = function(self)
  -- Component highlights
  for k, v in pairs(self:highlights()) do
    vim.api.nvim_set_hl(0, k, v)
  end
  -- Devicon highlights (devicon foreground with winbar background)
  for _, icon_table in pairs(require("nvim-web-devicons").get_icons()) do
    vim.api.nvim_set_hl(0, "WinbarDevIcon".. icon_table.name, { fg = icon_table.color, bg = self.colors().centerside_background })
  end
end

M.should_truncate = function(_, trunc_width)
  local current_width = vim.api.nvim_win_get_width(0)
  return current_width < trunc_width
end



--[[ Components ]]

-- Shroom icon to indicate active window
M.get_shroom = function(self)
  return {
    highlight = "%#WinbarShroom#",
    text = "ﳞ",
    length = vim.fn.strchars("ﳞ"),
  }
end

-- Devicon corresponding to buffer
M.get_devicon = function(self)
  local filename, fileext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
  local icon, group = require("nvim-web-devicons").get_icon(filename, fileext, { default = true })

  return {
    highlight = "%#winbar" .. group .. "#",
    text      = icon,
    length    = vim.fn.strchars(icon)
  }
end

-- Tail, relative, or active filepath of buffer
M.get_filepath = function(self)
  local filepaths = { tail = "%t", rel = "%f", abs = "%F" }
  local filepath = filepaths[self.filepath_type] or "%t"
  local is_modified = vim.opt.modified:get()

  return {
    highlight = is_modified and "%#WinbarFilepathModified#" or "%#WinbarFilepath#",
    text      = filepath,
    length    = vim.fn.strchars(filepath)
  }
end

-- Readonly indicator
M.get_readonly = function(self)
  local is_readonly = vim.opt.readonly:get()
  local readonly_text = is_readonly and " " .. self.readonly_icon or ""

  return {
    highlight = "%#WinbarReadonly#",
    text      = readonly_text,
    length    = vim.fn.strchars(readonly_text),
  }
end

-- Modified indicator
M.get_modified = function(self)
  local is_modified = vim.opt.modified:get()
  local modified_text = is_modified and " " .. self.modified_icon or ""

  return {
    highlight = "%#WinbarModified#",
    text      = modified_text,
    length    = vim.fn.strchars(modified_text),
  }
end

-- Treesitter code context
M.get_navic = function(self)
  local code_context = require("nvim-navic").get_location()                  -- Note: includes statusline/winbar highlighting
  local code_context_underwear = string.gsub(code_context, "%%%#.-%#", "")   -- Remove any highlight codes (e.g. %#Group#)
  local code_context_naked = string.gsub(code_context_underwear, "%%%*", "") -- Remove any default highlight codes (%*)

  return {
    text      = code_context,
    length    = vim.fn.strchars(code_context_naked),
  }
end

-- Space character for separating center components
M.get_space = function(self)
  return {
    highlight = "%#WinbarFilepath#",
    text      = " ",
    length    = 1,
  }
end



--[[ Edges ]]

M.get_leftside_left_edge = function(self)
  local icon = self:should_truncate(self.trunc_width) and self.leftside_left_edge_icon.truncated or self.leftside_left_edge_icon.normal
  return {
    highlight = "%#WinbarLeftsideEdge#",
    text = icon,
    length = vim.fn.strchars(icon),
  }
end

M.get_leftside_right_edge = function(self)
  local icon = self:should_truncate(self.trunc_width) and self.leftside_right_edge_icon.truncated or self.leftside_right_edge_icon.normal
  return {
    highlight = "%#WinbarLeftsideEdge#",
    text = icon,
    length = vim.fn.strchars(icon),
  }
end

-- Left edge/border of center components
M.get_centerside_left_edge = function(self)
  local should_trunc = self:should_truncate(self.trunc_width)
  local padding = should_trunc and "" or "%="

  return {
    active = {
      highlight = should_trunc and "%#WinbarCentersideLeftEdgeTrunc#" or "%#WinbarCentersideEdge#",
      text      = padding .. self.centerside_left_edge_icon,
      length    = vim.fn.strchars(self.centerside_left_edge_icon),
    },
    inactive = {
      highlight = "%#WinbarCentersideEdge#",
      text      = padding .. self.centerside_left_edge_icon,
      length    = vim.fn.strchars(self.centerside_left_edge_icon),
    },
  }
end

-- Right edge/border of center components
M.get_centerside_right_edge = function(self)
  return {
    highlight = "%#WinbarCentersideEdge#",
    text      = self.centerside_right_edge_icon .. "%=",
    length    = vim.fn.strchars(self.centerside_right_edge_icon),
  }
end



--[[ Padding ]]

-- Padding between left screen edge and leftmost component
M.get_left_padding = function()
  return {
    highlight = "%#Normal#",
    text = " ",
    length = 1,
  }
end

-- Padding between right screen edge and rightmost component
M.get_right_padding = function()
  return {
    highlight = "%#Normal#",
    text = " ",
    length = 1,
  }
end

-- Padding to keep the center components static
M.get_left_center_padding = function(self)
  return {
    active = {
      highlight = "%#Normal#",
      text      = self:should_truncate(self.trunc_width) and "" or string.rep(" ", self:right_length().active)
    },
    inactive = {
      highlight = "%#Normal#",
      text      = self:should_truncate(self.trunc_width) and "" or string.rep(" ", self:right_length().inactive)
    },
  }
end

-- Padding to keep the center components static
M.get_right_center_padding = function(self)
  return {
    active = {
      highlight = "%#Normal#",
      text      = self:should_truncate(self.trunc_width) and "" or string.rep(" ", self:left_length().active),
    },
    inactive = {
      highlight = "%#Normal#",
      text      = self:should_truncate(self.trunc_width) and "" or string.rep(" ", self:left_length().inactive),
    },
  }
end

-- Length of left components (used to calculate right_center_padding)
M.left_length = function(self)
  return {
    active = self:get_left_padding().length
           + self:get_leftside_left_edge().length
           + self:get_shroom().length
           + self:get_leftside_right_edge().length,

    inactive = self:get_left_padding().length,
  }
end

-- Length of right components (used to calculate left_center_padding)
M.right_length = function(self)
  return {
    active = self:get_navic().length
           + self:get_right_padding().length,

    inactive = self:get_navic().length
             + self:get_right_padding().length,
  }
end



--[[ Set winbar options ]]

-- Return winbar expression for active winbar
M.set_active = function(self)
  local space_table                 = self:get_space()
  local left_padding_table          = self:get_left_padding()
  local leftside_left_edge_table    = self:get_leftside_left_edge()
  local shroom_table                = self:get_shroom()
  local leftside_right_edge_table   = self:get_leftside_right_edge()
  local left_center_padding_table   = self:get_left_center_padding().active
  local centerside_left_edge_table  = self:get_centerside_left_edge().active
  local devicon_table               = self:get_devicon()
  local filepath_table              = self:get_filepath()
  local readonly_table              = self:get_readonly()
  local modified_table              = self:get_modified()
  local centerside_right_edge_table = self:get_centerside_right_edge()
  local right_center_padding_table  = self:get_right_center_padding().active
  local navic_table                 = self:get_navic()
  local right_padding_table         = self:get_right_padding()

  local space                 = space_table.highlight                 .. space_table.text
  local left_padding          = left_padding_table.highlight          .. left_padding_table.text
  local leftside_left_edge    = leftside_left_edge_table.highlight    .. leftside_left_edge_table.text
  local shroom                = shroom_table.highlight                .. shroom_table.text
  local leftside_right_edge   = leftside_right_edge_table.highlight   .. leftside_right_edge_table.text
  local left_center_padding   = left_center_padding_table.highlight   .. left_center_padding_table.text
  local centerside_left_edge  = centerside_left_edge_table.highlight  .. centerside_left_edge_table.text
  local devicon               = devicon_table.highlight               .. devicon_table.text
  local filepath              = filepath_table.highlight              .. filepath_table.text
  local readonly              = readonly_table.highlight              .. readonly_table.text
  local modified              = modified_table.highlight              .. modified_table.text
  local centerside_right_edge = centerside_right_edge_table.highlight .. centerside_right_edge_table.text
  local right_center_padding  = right_center_padding_table.highlight  .. right_center_padding_table.text
  local navic                 =                                          navic_table.text
  local right_padding         = right_padding_table.highlight         .. right_padding_table.text

  return table.concat({
    left_padding,
    leftside_left_edge,
    shroom,
    leftside_right_edge,
    left_center_padding,
    centerside_left_edge,
    devicon,
    space,
    filepath,
    readonly,
    modified,
    centerside_right_edge,
    right_center_padding,
    navic,
    right_padding,
  })
end

-- Return winbar expression for inactive winbar
M.set_inactive = function(self)
  local space_table                 = self:get_space()
  local left_padding_table          = self:get_left_padding()
  local leftside_left_edge_table    = self:get_leftside_left_edge()
  local shroom_table                = self:get_shroom()
  local leftside_right_edge_table   = self:get_leftside_right_edge()
  local left_center_padding_table   = self:get_left_center_padding().inactive
  local centerside_left_edge_table  = self:get_centerside_left_edge().inactive
  local devicon_table               = self:get_devicon()
  local filepath_table              = self:get_filepath()
  local readonly_table              = self:get_readonly()
  local modified_table              = self:get_modified()
  local centerside_right_edge_table = self:get_centerside_right_edge()
  local right_center_padding_table  = self:get_right_center_padding().inactive
  local navic_table                 = self:get_navic()
  local right_padding_table         = self:get_right_padding()

  local space                 = space_table.highlight                 .. space_table.text
  local left_padding          = left_padding_table.highlight          .. left_padding_table.text
  local leftside_left_edge    = leftside_left_edge_table.highlight    .. leftside_left_edge_table.text
  local shroom                = shroom_table.highlight                .. shroom_table.text
  local leftside_right_edge   = leftside_right_edge_table.highlight   .. leftside_right_edge_table.text
  local left_center_padding   = left_center_padding_table.highlight   .. left_center_padding_table.text
  local centerside_left_edge  = centerside_left_edge_table.highlight  .. centerside_left_edge_table.text
  local devicon               = devicon_table.highlight               .. devicon_table.text
  local filepath              = filepath_table.highlight              .. filepath_table.text
  local readonly              = readonly_table.highlight              .. readonly_table.text
  local modified              = modified_table.highlight              .. modified_table.text
  local centerside_right_edge = centerside_right_edge_table.highlight .. centerside_right_edge_table.text
  local right_center_padding  = right_center_padding_table.highlight  .. right_center_padding_table.text
  local navic                 =                                          navic_table.text
  local right_padding         = right_padding_table.highlight         .. right_padding_table.text

  return table.concat({
    left_padding,
    left_center_padding,
    centerside_left_edge,
    devicon,
    space,
    filepath,
    readonly,
    modified,
    centerside_right_edge,
    right_center_padding,
    navic,
    right_padding,
  })
end

-- Metatable to set winbar option
Winbar = setmetatable(M, {
  __call = function(winbar, mode)
    --[[ if vim.api.nvim_win_get_config(0).zindex then return "" end -- Disable winbar for floating windows ]] -- https://github.com/neovim/neovim/issues/18660
    if mode == "active" then return winbar:set_active() end
    if mode == "inactive" then return winbar:set_inactive() end
  end
})


-- Autocommands to set winbar options
vim.api.nvim_create_augroup("Winbar", {clear = true})
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group   = "Winbar",
  pattern = {'*'},
  command = "if has_key(v:lua.vim.api.nvim_win_get_config(0), 'zindex') | setlocal winbar= | else | setlocal winbar=%{%v:lua.Winbar('active')%} | endif"
  --[[ command = "setlocal winbar=%{%v:lua.Winbar('active')%}" ]] -- https://github.com/neovim/neovim/issues/18660
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group   = "Winbar",
  pattern = {'*'},
  command = "if has_key(v:lua.vim.api.nvim_win_get_config(0), 'zindex') | setlocal winbar= | else | silent! setlocal winbar=%{%v:lua.Winbar('inactive')%} | endif" -- silent! needed to suppress unusual error when entering dressing.nvim window
  --[[ command = "setlocal winbar=%{%v:lua.Winbar('inactive')%}" ]] -- https://github.com/neovim/neovim/issues/18660
})

return M
