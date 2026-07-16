#!/usr/bin/env bash
#
# install.sh — symlink dotfiles into place (macOS / Linux).
# Re-runnable and safe: backs up any existing real file before linking.
#
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# link <source-in-repo> <target-in-home>
link() {
  local src="$DOTFILES/$1"
  local dst="$2"

  if [ ! -e "$src" ]; then
    echo "  skip   $1 (not in repo)"
    return
  fi

  mkdir -p "$(dirname "$dst")"

  # If a real file/dir already exists (not our symlink), back it up.
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "  backup $dst -> $BACKUP_DIR/"
  fi

  ln -sfn "$src" "$dst"
  echo "  link   $1 -> $dst"
}

echo "Linking dotfiles from $DOTFILES"

link "wezterm/wezterm.lua"     "$HOME/.config/wezterm/wezterm.lua"
link "git/.gitconfig"          "$HOME/.gitconfig"
link "git/.gitignore_global"   "$HOME/.gitignore_global"
link "zsh/.zshrc"              "$HOME/.zshrc"
link "starship/starship.toml"  "$HOME/.config/starship.toml"

echo "Done."
[ -d "$BACKUP_DIR" ] && echo "Existing files were backed up to $BACKUP_DIR"