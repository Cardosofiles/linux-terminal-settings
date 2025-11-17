# ================================
# ~/.zshrc - Full Stack Dev Senior
# ================================

# ------------------------
# Powerlevel10k instant prompt
# ------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=on
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------
# Oh My Zsh
# ------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  autojump
  fzf
  history-substring-search
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7f7f7f'
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ------------------------
# Core Settings
# ------------------------
export TERM="xterm-256color"
DISABLE_AUTO_TITLE=true
ENABLE_CORRECTION="true"

# ------------------------
# Version Managers
# ------------------------

# SDKMAN (Java / Maven / Gradle)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# --- FIX Java (WSL + Gradle + SDKMAN) ---
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export PATH="$JAVA_HOME/bin:$PATH"

# FNM (Node.js)
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Corepack (npm, pnpm, yarn)
corepack enable >/dev/null 2>&1

# Pyenv (Python)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"

# ------------------------
# Autojump
# ------------------------
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh

# ------------------------
# IDE Aliases
# ------------------------
alias idea='/mnt/c/Program\ Files/JetBrains/IntelliJ\ IDEA\ Community\ Edition\ 2024.3.3/bin/idea64.exe'
alias webstorm='"/mnt/c/Program Files/JetBrains/WebStorm 2025.2.2/bin/webstorm64.exe"'
alias cursor='/mnt/c/Users/cardo/AppData/Local/Programs/Cursor/cursor.exe'

# ------------------------
# Custom Script Aliases
# ------------------------
alias git-push-origin='~/bin/git-push-origin.sh'
alias git-push-faculdade='~/bin/git-push-faculdade.sh'
alias next-shadcn-biome='~/bin/next-shadcn-biome.sh'
alias next-shadcn-prettierrc='~/bin/next-shadcn-prettierrc.sh'
alias restart-docker='~/bin/restart-docker.sh'
alias docker-login='~/bin/docker-login.sh'
alias react-router-v7='~/bin/react-router-v7.sh'
alias create-fastify-app='~/bin/fastify-postgresql-script.sh'
alias versions='~/bin/check-version.sh'

# Task Master
alias tm='task-master'
alias taskmaster='task-master'

# ------------------------
# Powerlevel10k Config
# ------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
