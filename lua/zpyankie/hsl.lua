---@module 'zpyankie.hsl'
--- Color conversion utilities
--- Provides HSL/RGB/Hex color format conversion functions
--- Original source: https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua
---
--- Usage:
---   - Press <leader>r on a line with hex colors to convert them to HSL
---   - Useful for CSS, styling work, and color manipulation

local M = {}

local hexChars = "0123456789abcdef"

--- Convert hex color string to RGB values
---@param hex string Hex color code (e.g., "#ff5733")
---@return table RGB values normalized to [0,1] range
function M.hex_to_rgb(hex)
  hex = string.lower(hex)
  local ret = {}
  for i = 0, 2 do
    local char1 = string.sub(hex, i * 2 + 2, i * 2 + 2)
    local char2 = string.sub(hex, i * 2 + 3, i * 2 + 3)
    local digit1 = string.find(hexChars, char1) - 1
    local digit2 = string.find(hexChars, char2) - 1
    ret[i + 1] = (digit1 * 16 + digit2) / 255.0
  end
  return ret
end

--- Convert RGB color values to HSL
--- Conversion formula adapted from http://en.wikipedia.org/wiki/HSL_color_space
--- Assumes r, g, and b are in the range [0, 1]
---@param r number Red component (0-1)
---@param g number Green component (0-1)
---@param b number Blue component (0-1)
---@return number h Hue (0-360)
---@return number s Saturation (0-100)
---@return number l Lightness (0-100)
function M.rgbToHsl(r, g, b)
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h = 0
  local s = 0
  local l = 0

  l = (max + min) / 2

  if max == min then
    h, s = 0, 0 -- achromatic (gray)
  else
    local d = max - min
    if l > 0.5 then
      s = d / (2 - max - min)
    else
      s = d / (max + min)
    end

    -- Calculate hue based on which component is maximum
    if max == r then
      h = (g - b) / d
      if g < b then
        h = h + 6
      end
    elseif max == g then
      h = (b - r) / d + 2
    elseif max == b then
      h = (r - g) / d + 4
    end
    h = h / 6
  end

  return h * 360, s * 100, l * 100
end

--- Convert HSL color values to RGB
--- Conversion formula adapted from http://en.wikipedia.org/wiki/HSL_color_space
---@param h number Hue (0-1)
---@param s number Saturation (0-1)
---@param l number Lightness (0-1)
---@return number r Red (0-255)
---@return number g Green (0-255)
---@return number b Blue (0-255)
function M.hslToRgb(h, s, l)
  local r, g, b

  if s == 0 then
    r, g, b = l, l, l -- achromatic
  else
    --- Helper function for hue to RGB conversion
    ---@param p number
    ---@param q number
    ---@param t number
    ---@return number
    local function hue2rgb(p, q, t)
      if t < 0 then
        t = t + 1
      end
      if t > 1 then
        t = t - 1
      end
      if t < 1 / 6 then
        return p + (q - p) * 6 * t
      end
      if t < 1 / 2 then
        return q
      end
      if t < 2 / 3 then
        return p + (q - p) * (2 / 3 - t) * 6
      end
      return p
    end

    local q
    if l < 0.5 then
      q = l * (1 + s)
    else
      q = l + s - l * s
    end
    local p = 2 * l - q

    r = hue2rgb(p, q, h + 1 / 3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1 / 3)
  end

  return r * 255, g * 255, b * 255
end

--- Convert hex color to HSL string
---@param hex string Hex color code (e.g., "#ff5733")
---@return string HSL string (e.g., "hsl(14, 91, 60)")
function M.hexToHSL(hex)
  local rgb = M.hex_to_rgb(hex)
  local h, s, l = M.rgbToHsl(rgb[1], rgb[2], rgb[3])

  return string.format("hsl(%d, %d, %d)", math.floor(h + 0.5), math.floor(s + 0.5), math.floor(l + 0.5))
end

--- Convert HSL values to hex color string
---@param h number Hue (0-360)
---@param s number Saturation (0-100)
---@param l number Lightness (0-100)
---@return string Hex color code (e.g., "#ff5733")
function M.hslToHex(h, s, l)
  local r, g, b = M.hslToRgb(h / 360, s / 100, l / 100)
  return string.format("#%02x%02x%02x", r, g, b)
end

--- Replace all hex colors in current line with HSL equivalents
--- Bound to <leader>r keymap
---@return nil
function M.replaceHexWithHSL()
  -- Get the current line number and content
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  local line_content = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]

  -- Find all hex color patterns (#RRGGBB) and replace with HSL
  for hex in line_content:gmatch("#[0-9a-fA-F]+") do
    local hsl = M.hexToHSL(hex)
    line_content = line_content:gsub(hex, hsl)
  end

  -- Update the line with converted colors
  vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { line_content })

  vim.notify("Converted hex colors to HSL", vim.log.levels.INFO)
end

return M
