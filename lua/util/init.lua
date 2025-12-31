---@module 'util'
--- Common utility functions
--- Reusable helper functions to keep code DRY across the configuration

local M = {}

--- Create a keymap with default options
--- Reduces boilerplate when setting multiple keymaps
---@param mode string|table Mode(s) for the keymap (e.g., "n", "v", {"n", "v"})
---@param lhs string Left-hand side (key combination)
---@param rhs string|function Right-hand side (command or function)
---@param opts? table Optional keymap options
---@return nil
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false -- Default to silent
  opts.noremap = opts.noremap ~= false -- Default to noremap
  vim.keymap.set(mode, lhs, rhs, opts)
end

--- Safe require - returns nil if module doesn't exist instead of error
--- Useful for optional dependencies
---@param module string Module name to require
---@return table|nil module The required module or nil if not found
function M.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Failed to load module: " .. module, vim.log.levels.WARN)
    return nil
  end
  return result
end

--- Check if a plugin is loaded
---@param plugin string Plugin name
---@return boolean loaded Whether the plugin is loaded
function M.has_plugin(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

--- Create an augroup and autocommands
--- Simplifies autocommand creation with automatic group management
---@param name string Augroup name
---@param commands table List of autocommand definitions
---@return nil
function M.augroup(name, commands)
  local group = vim.api.nvim_create_augroup(name, { clear = true })
  for _, cmd in ipairs(commands) do
    local event = cmd.event
    local pattern = cmd.pattern or "*"
    local callback = cmd.callback
    local desc = cmd.desc or ""
    
    vim.api.nvim_create_autocmd(event, {
      group = group,
      pattern = pattern,
      callback = callback,
      desc = desc,
    })
  end
end

--- Get visual selection text
--- Returns the currently selected text in visual mode
---@return string selection The selected text
function M.get_visual_selection()
  local _, ls, cs = unpack(vim.fn.getpos("v"))
  local _, le, ce = unpack(vim.fn.getpos("."))
  return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end

--- Toggle boolean option
---@param option string Option name (e.g., "number", "relativenumber")
---@return nil
function M.toggle_option(option)
  vim.opt[option] = not vim.opt[option]:get()
  vim.notify(string.format("%s %s", option, vim.opt[option]:get() and "enabled" or "disabled"), vim.log.levels.INFO)
end

--- Check if we're in a git repository
---@return boolean in_git Whether current directory is in a git repo
function M.is_git_repo()
  local git_dir = vim.fn.finddir(".git", ".;")
  return git_dir ~= ""
end

--- Get the root directory of current project
--- Looks for common project markers
---@return string|nil root_dir The root directory or nil if not found
function M.get_root_dir()
  local markers = { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml" }
  for _, marker in ipairs(markers) do
    local found = vim.fn.findfile(marker, ".;")
    if found ~= "" then
      return vim.fn.fnamemodify(found, ":h")
    end
  end
  return nil
end

--- Execute a function and time it
--- Useful for performance profiling
---@param fn function Function to execute
---@param label? string Optional label for the timing output
---@return any result The function's return value
function M.time_it(fn, label)
  label = label or "Function"
  local start = vim.loop.hrtime()
  local result = fn()
  local elapsed = (vim.loop.hrtime() - start) / 1e6 -- Convert to milliseconds
  vim.notify(string.format("%s took %.2fms", label, elapsed), vim.log.levels.INFO)
  return result
end

--- Deep merge two tables
---@param t1 table First table
---@param t2 table Second table (takes precedence)
---@return table merged The merged table
function M.deep_merge(t1, t2)
  local result = vim.deepcopy(t1)
  for k, v in pairs(t2) do
    if type(v) == "table" and type(result[k]) == "table" then
      result[k] = M.deep_merge(result[k], v)
    else
      result[k] = v
    end
  end
  return result
end

return M
