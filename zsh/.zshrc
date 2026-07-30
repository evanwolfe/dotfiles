# ~/.zshrc — initial

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

# Sensible defaults
export EDITOR="vim"
export CLICOLOR=1

# Aliases
alias ll='ls -lah'
alias gs='git status'

# Machine-specific, untracked overrides
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# ── Autosuggestions (gray ghost text; accept with Right arrow) ─────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6e6a86"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ── Up/Down = prefix history search ────────────────────────────────────────
# Type "az login" then press Up to cycle only matching past commands.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# ── Starship prompt ────────────────────────────────────────────────────────
eval "$(starship init zsh)"

# ── Syntax highlighting (must be last) ─────────────────────────────────────
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh