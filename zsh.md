# Powerlevel10k instant prompt (deixe no topo)

if [[-r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"]]; then
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH básico

export PATH="$HOME/.local/bin:$PATH"

# Oh My Zsh

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Preferências do Oh My Zsh (defina ANTES de carregar o OMZ)

ENABLE_CORRECTION="true"

# Plugins (ordem importa: syntax-highlighting por último)

plugins=(git fzf zsh-autosuggestions history-substring-search autojump zsh-syntax-highlighting)

# Carrega Oh My Zsh

source "$ZSH/oh-my-zsh.sh"

# Bun

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm + Node (padrão recomendado)

eval "$(fnm env --use-on-cd)"

# pnpm (Corepack ou PATH dedicado)

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in _":$PNPM_HOME:"_) ;; \*) export PATH="$PNPM_HOME:$PATH" ;; esac

# SDKMAN (Java/Maven/Gradle)

[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# FZF keybindings (se instalado via script do fzf)

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Aliases úteis (exemplos)

alias idea='/mnt/c/Program\ Files/JetBrains/IntelliJ\ IDEA\ Community\ Edition\ 2024.3.3/bin/idea64.exe'
alias cursor='/mnt/c/Users/cardo/AppData/Local/Programs/Cursor/cursor.exe'
alias git-push-origin='~/bin/git-push-origin.sh'
alias git-push-faculdade='~/bin/git-push-faculdade.sh'
alias next-shadcn-biome='~/bin/next-shadcn-biome.sh'
alias next-shadcn-prettierrc='~/bin/next-shadcn-prettierrc.sh'
alias restart-docker='~/bin/restart-docker.sh'
alias docker-login='~/bin/docker-login.sh'
alias react-router-v7='~/bin/react-router-v7.sh'
alias create-fastify-app='~/bin/fastify-postgresql-script.sh'

# Terminal

export TERM="xterm-256color"

# Powerlevel10k config

[[-f ~/.p10k.zsh]] && source ~/.p10k.zsh

# History substring search keybindings (setas ↑/↓)

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
