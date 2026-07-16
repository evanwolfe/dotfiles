# ~/.zshrc — initial

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS

# Sensible defaults
export EDITOR="vim"
export CLICOLOR=1

# Aliases
alias ll='ls -lah'
alias gs='git status'
alias ..='cd ..'

# Starship prompt (if installed)
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Machine-specific, untracked overrides
[ -f ~/.zshrc.local ] && source ~/.zshrc.local