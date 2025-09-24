#!/usr/bin/env bash
set -euo pipefail

# Idempotent setup script for a modern Dev Terminal on WSL Ubuntu
# Includes: zsh, oh-my-zsh, powerlevel10k, plugins, fzf, fnm + pnpm, SDKMAN (java/maven/gradle), Docker group, and extras.

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RED="\033[1;31m"
NC="\033[0m"

log() { echo -e "${BLUE}==>${NC} $*"; }
ok() { echo -e "${GREEN}✔${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC} $*"; }
err() { echo -e "${RED}✖${NC} $*"; }

ensure_cmd() {
  command -v "$1" >/dev/null 2>&1
}

append_if_missing() {
  local line="$1" file="$2"
  grep -qxF "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

replace_or_append() {
  local pattern="$1" replacement="$2" file="$3"
  if grep -qE "$pattern" "$file" 2>/dev/null; then
    sed -i "s|$pattern|$replacement|" "$file"
  else
    echo "$replacement" >> "$file"
  fi
}

require_wsl_ubuntu() {
  if ! grep -qi microsoft /proc/version 2>/dev/null; then
    warn "Este script foi pensado para WSL. Continuando mesmo assim..."
  fi
  if ! grep -qi ubuntu /etc/os-release 2>/dev/null; then
    warn "Distribuição não é Ubuntu. Alguns comandos podem falhar."
  fi
}

setup_apt() {
  log "Atualizando sistema e pacotes base"
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install -y \
    curl git unzip build-essential zip htop wget ca-certificates gnupg lsb-release \
    fzf bat fd-find tree neofetch zsh
  ok "Apt configurado"
}

setup_zsh_ohmyzsh() {
  log "Configurando Zsh e Oh My Zsh"

  # Definir zsh como shell padrão se ainda não for
  local current_shell
  current_shell="${SHELL:-}"
  if [[ "${current_shell##*/}" != "zsh" ]]; then
    if command -v zsh >/dev/null; then
      chsh -s "$(command -v zsh)" "$USER" || warn "Não foi possível alterar o shell automaticamente. Altere manualmente com chsh."
    fi
  fi

  # Instalar Oh My Zsh se ausente (modo não interativo)
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  ok "Zsh e Oh My Zsh prontos"
}

setup_powerlevel10k() {
  log "Instalando tema Powerlevel10k"
  local theme_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  if [[ ! -d "$theme_dir" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"
  fi
  local zshrc="$HOME/.zshrc"
  touch "$zshrc"
  if grep -q '^ZSH_THEME=' "$zshrc"; then
    sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$zshrc"
  else
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$zshrc"
  fi
  ok "Powerlevel10k instalado e configurado no .zshrc"
}

setup_zsh_plugins() {
  log "Instalando plugins do Zsh (autosuggestions, syntax-highlighting)"
  local custom_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  [[ -d "$custom_dir/plugins" ]] || mkdir -p "$custom_dir/plugins"

  [[ -d "$custom_dir/plugins/zsh-autosuggestions" ]] || \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$custom_dir/plugins/zsh-autosuggestions"

  [[ -d "$custom_dir/plugins/zsh-syntax-highlighting" ]] || \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom_dir/plugins/zsh-syntax-highlighting"

  local zshrc="$HOME/.zshrc"
  touch "$zshrc"
  # Atualiza linha de plugins, preservando existentes e adicionando os necessários
  if grep -q '^plugins=' "$zshrc"; then
    local line existing new combined unique
    line=$(grep '^plugins=' "$zshrc" | head -n1)
    existing=$(echo "$line" | sed -E 's/^plugins=\((.*)\)/\1/')
    new="git zsh-autosuggestions zsh-syntax-highlighting"
    combined="$new $existing"
    unique=$(echo "$combined" | tr ' ' '\n' | awk 'NF{if(!seen[$0]++){print}}' | xargs)
    sed -i "s|^plugins=.*|plugins=(${unique})|" "$zshrc"
  else
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$zshrc"
  fi
  ok "Plugins configurados no .zshrc"
}

setup_fnm_node_pnpm() {
  log "Instalando fnm (Fast Node Manager) e Node LTS"
  if [[ ! -d "$HOME/.fnm" ]]; then
    curl -fsSL https://fnm.vercel.app/install | bash
  fi

  # Disponibiliza fnm nesta execução
  export PATH="$HOME/.fnm:$PATH"
  eval "$(fnm env --shell bash)"

  # Node LTS padrão
  if ! node -v >/dev/null 2>&1; then
    fnm install --lts
    fnm default lts-latest
  fi
  ok "Node.js instalado (via fnm)"

  # Persistir no .zshrc
  append_if_missing 'eval "$(fnm env --use-on-cd)"' "$HOME/.zshrc"

  log "Ativando pnpm via Corepack"
  if ensure_cmd corepack; then
    corepack enable || true
    corepack prepare pnpm@latest --activate || true
  fi
  if ! ensure_cmd pnpm; then
    if ensure_cmd npm; then
      npm install -g pnpm
    else
      warn "npm não encontrado; pnpm não pôde ser instalado globalmente."
    fi
  fi
  ok "pnpm pronto ($(pnpm -v 2>/dev/null || echo 'não detectado'))"
}

setup_sdkman_java() {
  log "Instalando SDKMAN, Java 21 Temurin, Maven e Gradle"
  if [[ ! -d "$HOME/.sdkman" ]]; then
    curl -s "https://get.sdkman.io" | bash
  fi
  # Torna sdkman disponível nesta sessão
  # shellcheck disable=SC1091
  source "$HOME/.sdkman/bin/sdkman-init.sh"

  # Instala candidatos (idempotente: sdk ignora se já instalados)
  sdk install java 21.0.5-tem || true
  sdk install maven || true
  sdk install gradle || true
  ok "SDKMAN e ferramentas Java configurados"
}

setup_docker_group() {
  log "Configurando Docker para uso sem sudo (lado WSL)"
  if ! getent group docker >/dev/null; then
    sudo groupadd docker || true
  fi
  if ! id -nG "$USER" | grep -qw docker; then
    sudo usermod -aG docker "$USER" || warn "Falha ao adicionar usuário ao grupo docker"
    warn "Você precisará encerrar a sessão do WSL (wsl --shutdown) ou reiniciar para aplicar o grupo docker."
  fi
  ok "Grupo docker verificado"
}

setup_extras() {
  log "Ajustando utilitários extras e atalhos"
  mkdir -p "$HOME/.local/bin"
  # fd e bat em Ubuntu são fdfind e batcat
  if command -v fdfind >/dev/null; then
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  fi
  if command -v batcat >/dev/null; then
    ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
  fi
  append_if_missing 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc"
  ok "Extras configurados"
}

post_instructions() {
  echo
  ok "Setup concluído!"
  cat <<'EOF'

Próximos passos:
1) Feche e reabra o terminal (ou execute: wsl --shutdown no PowerShell) para aplicar todas as mudanças (grupo docker/shell padrão).
2) Ao abrir o Zsh, o assistente do Powerlevel10k será iniciado: configure como preferir.
3) No Windows Terminal/VS Code, selecione uma Nerd Font (ex.: MesloLGS NF) para ver ícones corretamente.

Verificações rápidas:
  zsh --version
  echo $SHELL
  node -v && npm -v && pnpm -v
  java -version && mvn -v && gradle -v
  docker run hello-world   # requer Docker Desktop com integração WSL ativada

EOF
}

main() {
  require_wsl_ubuntu
  setup_apt
  setup_zsh_ohmyzsh
  setup_powerlevel10k
  setup_zsh_plugins
  setup_fnm_node_pnpm
  setup_sdkman_java
  setup_docker_group
  setup_extras
  post_instructions
}

main "$@"
