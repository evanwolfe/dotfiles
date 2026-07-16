# dotfiles

A plain, tool-agnostic collection of my configuration files. Each tool gets its
own folder. No dotfile manager, no templating engine — just git plus symlinks
(or copies). Pull the repo on any machine and point each tool at its config.

## Layout

```
dotfiles/
├── README.md
├── install.sh                 # optional: symlinks everything into place (macOS/Linux)
├── .gitignore
├── wezterm/
│   └── wezterm.lua
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── zsh/
│   └── .zshrc
├── starship/
│   └── starship.toml
└── powershell/
    └── Microsoft.PowerShell_profile.ps1
```

## Where each file lands

| Repo path                                   | macOS / Linux target                              | Windows target                                                        |
| ------------------------------------------- | ------------------------------------------------- | --------------------------------------------------------------------- |
| `wezterm/wezterm.lua`                       | `~/.config/wezterm/wezterm.lua`                   | `%USERPROFILE%\.config\wezterm\wezterm.lua`                           |
| `git/.gitconfig`                            | `~/.gitconfig`                                    | `%USERPROFILE%\.gitconfig`                                            |
| `git/.gitignore_global`                     | `~/.gitignore_global`                             | `%USERPROFILE%\.gitignore_global`                                    |
| `zsh/.zshrc`                                | `~/.zshrc`                                         | n/a                                                                   |
| `starship/starship.toml`                    | `~/.config/starship.toml`                         | `%USERPROFILE%\.config\starship.toml`                                |
| `powershell/Microsoft.PowerShell_profile.ps1` | n/a                                             | `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`            |

## Setup

### macOS / Linux

```bash
git clone https://github.com/<you>/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh          # symlinks everything listed above
```

Or link a single tool by hand:

```bash
mkdir -p ~/.config/wezterm
ln -sf ~/dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
```

### Windows (PowerShell)

`$HOME` maps to `C:\Users\<you>`, so the same `.config` path works.
Enable Developer Mode (or run as admin) so symlinks are allowed:

```powershell
git clone https://github.com/<you>/dotfiles.git $HOME\dotfiles
New-Item -ItemType Directory -Force $HOME\.config\wezterm | Out-Null
New-Item -ItemType SymbolicLink -Force `
  -Path $HOME\.config\wezterm\wezterm.lua `
  -Target $HOME\dotfiles\wezterm\wezterm.lua
```

## Notes

- **Copy vs. symlink:** symlinks mean edits to the live file show up in `git status`
  automatically. Copies are a snapshot — remember to copy changes *back* into the
  repo before committing.
- **Secrets stay out.** See `.gitignore`. For machine-specific tweaks, keep a
  local, untracked override (e.g. `~/.zshrc.local`) and source it from the tracked
  file.
- **One config, all OSes.** `wezterm.lua` branches internally on
  `wezterm.target_triple`, so a single file serves macOS, Windows, and Linux.