#!/usr/bin/env bash
set -e

echo "------------------------------------------------------------"
echo " 🚀 Configurando Ambiente Full Stack Dev Senior no WSL Ubuntu"
echo "------------------------------------------------------------"

# Dependências base
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git wget unzip build-essential ca-certificates \
    zsh fzf autojump python3 python3-pip software-properties-common \
    neofetch gnupg lsb-release apt-transport-https

# ------------------------
# Instalar Oh My Zsh
# ------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💡 Instalando Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ------------------------
# Plugins e Tema
# ------------------------
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

git clone --depth 1 https://github.com/romkatv/powerlevel10k.git \
  $ZSH_CUSTOM/themes/powerlevel10k || true

git clone https://github.com/zsh-users/zsh-autosuggestions \
  $ZSH_CUSTOM/plugins/zsh-autosuggestions || true

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || true

# ------------------------
# FNM (Node)
# ------------------------
echo "💡 Instalando FNM (Node Version Manager)..."
curl -fsSL https://fnm.vercel.app/install | bash
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"
fnm install --lts
fnm default lts-latest

# ------------------------
# Bun
# ------------------------
echo "💡 Instalando Bun..."
curl -fsSL https://bun.sh/install | bash

# ------------------------
# SDKMAN (Java/Maven/Gradle)
# ------------------------
echo "💡 Instalando SDKMAN + Java + Maven + Gradle..."
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 21.0.5-tem || true
sdk install maven || true
sdk install gradle || true

# ------------------------
# Pyenv
# ------------------------
echo "💡 Instalando Pyenv..."
if [ ! -d "$HOME/.pyenv" ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
fi

# ------------------------
# GitHub CLI
# ------------------------
echo "💡 Instalando GitHub CLI..."
type -p gh >/dev/null || {
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |
    sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update
  sudo apt install gh -y
}

# ------------------------
# DOCKER ENGINE + COMPOSE (WSL)
# ------------------------
echo "🐋 Instalando Docker Engine + Compose..."

sudo apt remove docker docker-engine docker.io containerd runc 2>/dev/null || true

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
  sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" |
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker || true
sudo usermod -aG docker $USER

echo "🔄 Aplicando permissões docker agora (sem reiniciar terminal)..."
newgrp docker <<EONG
echo "✅ Docker liberado para o usuário."
EONG

# Habilitar systemd no WSL
echo "🛠️ Ativando systemd no WSL..."
sudo bash -c 'echo -e "[boot]\nsystemd=true" > /etc/wsl.conf'

# ------------------------
# Criando ~/.zshrc FINAL (corrigido com pyenv fix)
# ------------------------
echo "💾 Gravando ~/.zshrc definitivo..."
cat > ~/.zshrc << 'EOF'
# ================================
# ~/.zshrc - Full Stack Dev Senior
# ================================

typeset -g POWERLEVEL9K_INSTANT_PROMPT=on
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

export TERM="xterm-256color"
DISABLE_AUTO_TITLE=true
ENABLE_CORRECTION="true"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

corepack enable >/dev/null 2>&1

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh

alias idea='/mnt/c/Program\ Files/JetBrains/IntelliJ\ IDEA\ Community\ Edition\ 2024.3.3/bin/idea64.exe'
alias webstorm='"/mnt/c/Program Files/JetBrains/WebStorm 2025.2.2/bin/webstorm64.exe"'
alias cursor='/mnt/c/Users/cardo/AppData/Local/Programs/Cursor/cursor.exe'

alias git-push-origin='~/bin/git-push-origin.sh'
alias git-push-faculdade='~/bin/git-push-faculdade.sh'
alias next-shadcn-biome='~/bin/next-shadcn-biome.sh'
alias next-shadcn-prettierrc='~/bin/next-shadcn-prettierrc.sh'
alias restart-docker='~/bin/restart-docker.sh'
alias docker-login='~/bin/docker-login.sh'
alias react-router-v7='~/bin/react-router-v7.sh'
alias create-fastify-app='~/bin/fastify-postgresql-script.sh'
alias versions='~/bin/check-version.sh'

alias tm='task-master'
alias taskmaster='task-master'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

echo "✅ Ambiente configurado com sucesso!"
echo "⚠️ IMPORTANTE: Reinicie o WSL para completar a instalação:"
echo "   -> wsl --shutdown"
echo "   Abra o terminal novamente."
