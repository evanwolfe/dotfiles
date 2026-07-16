-- ~/.config/wezterm/wezterm.lua
local wezterm = require 'wezterm'
local config = wezterm.config_builder() -- catches typo'd keys at startup

--------------------------------------------------------------------------------
-- OS detection (portable branching)
--------------------------------------------------------------------------------
local triple = wezterm.target_triple
local is_mac     = triple:find('apple') ~= nil
local is_windows = triple:find('windows') ~= nil
local is_linux   = triple:find('linux') ~= nil

--------------------------------------------------------------------------------
-- Appearance: rose-pine-moon
--------------------------------------------------------------------------------
config.color_scheme = 'rose-pine-moon'   -- built-in (Gogh import)

config.colors = {
  selection_fg = '#e0def4', -- Rosé Pine Moon "text"
  selection_bg = '#44415a', -- Rosé Pine Moon "highlight med"
}

config.font = wezterm.font_with_fallback {
  { family = 'Hack Nerd Font', weight = 'Regular' },
  'Hack Nerd Font Mono',
  'monospace',
}
config.font_size = is_mac and 16.0 or 14.0   -- macOS Retina runs a touch larger
config.line_height = 1.1

config.window_background_opacity = 0.98
config.window_decorations = 'RESIZE'
config.window_padding = { left = 6, right = 6, top = 6, bottom = 4 }
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.scrollback_lines = 10000
config.audible_bell = 'Disabled'

--------------------------------------------------------------------------------
-- Shell / launch per OS
--------------------------------------------------------------------------------
if is_windows then
  -- Prefer PowerShell 7 if present, else fall back to Windows PowerShell
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  config.launch_menu = {
    { label = 'PowerShell 7', args = { 'pwsh.exe', '-NoLogo' } },
    { label = 'Command Prompt', args = { 'cmd.exe' } },
    { label = 'WSL (Ubuntu)', args = { 'wsl.exe', '~' } },
  }
elseif is_mac then
  config.default_prog = { '/bin/zsh', '-l' }
elseif is_linux then
  config.default_prog = { '/usr/bin/bash', '-l' }
end

--------------------------------------------------------------------------------
-- Keybindings (kept OS-consistent; SUPER = Cmd on mac, use CTRL|SHIFT elsewhere)
--------------------------------------------------------------------------------
local mod = is_mac and 'SUPER' or 'CTRL|SHIFT'
config.keys = {
  { key = 'd', mods = mod,          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = mod .. '|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = mod,          action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 't', mods = mod,          action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'p', mods = mod,          action = wezterm.action.ActivateCommandPalette },
}

return config
