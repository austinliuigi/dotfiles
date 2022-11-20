require("tint").setup({
  tint = -45,  -- Darken colors, use a positive value to brighten
  saturation = 0.6,  -- Saturation to preserve
  transforms = {
    require("tint.transforms").tint_with_threshold(-50, GetHiVal("Comment", "foreground"), 10),  -- Try to tint by `-50`, but keep all colors at least `100` away from comment foreground
    require("tint.transforms").saturate(0.5),
  },
  tint_background_colors = false,  -- Tint background portions of highlight groups
  highlight_ignore_patterns = { "WinSeparator", "CursorLine", "NonText", "EndOfBuffer", "WinBar.*", "Status.*", "IndentBlankline.*" },  -- Highlight group patterns to ignore, see `string.find`
  window_ignore_function = function(winid)
    local bufid = vim.api.nvim_win_get_buf(winid)
    local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
    local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

    -- Do not tint `terminal` or floating windows, tint everything else
    return buftype == "terminal" or floating
  end
})