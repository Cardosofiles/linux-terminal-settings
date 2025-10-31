<div align="center" id="top">

<h1 align="center">🚀 Ambiente Dev no WSL (Ubuntu) – Guia Completo</h1>

[![Ambiente de Desenvolvimento](https://img.shields.io/badge/Ambiente-Desenvolvimento-6C63FF?style=for-the-badge)](#índice)
[![WSL](https://img.shields.io/badge/WSL-Enabled-0078D4?style=for-the-badge&logo=windows&logoColor=white)](https://learn.microsoft.com/windows/wsl/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-Linux-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/wsl)
[![Node.js](https://img.shields.io/badge/Node.js-Setup-339933?style=for-the-badge&logo=node.js&logoColor=white)](#7-nodejs-com-fnm-fast-node-manager)
[![Java](https://img.shields.io/badge/Java-SDKMAN-007396?style=for-the-badge&logo=java&logoColor=white)](#8-java-maven-e-gradle-com-sdkman)
[![Docker](https://img.shields.io/badge/Docker-WSL-2496ED?style=for-the-badge&logo=docker&logoColor=white)](#9-docker-no-wsl)
[![Git](https://img.shields.io/badge/Git-Config-F05032?style=for-the-badge&logo=git&logoColor=white)](#configurar-git-global)
[![GitHub](https://img.shields.io/badge/GitHub-CLI-181717?style=for-the-badge&logo=github&logoColor=white)](#11-github-cli-e-chave-ssh)

Este guia configura um terminal moderno e produtivo no Windows via WSL (Ubuntu), com Zsh + Oh My Zsh, tema Powerlevel10k, plugins úteis, FZF, Node.js (fnm + pnpm), Java/Maven/Gradle (SDKMAN!), Docker integrado ao WSL e utilitários extras. Ao final, você terá um terminal rápido, bonito e pronto para desenvolvimento.

[![My Skills](https://skillicons.dev/icons?i=windows,powershell,linux,ubuntu,java,maven,gradle,nodejs,npm,pnpm,docker&theme=light)](https://skillicons.dev)

</div>

- Testado em: Windows 11 + WSL (Ubuntu)
- Shell: `zsh`

## Índice

- [Introdução e Pré-requisitos](#pré-requisitos)
- [Instalação do WSL (Ubuntu)](#1-instale-e-configure-o-wsl-ubuntu)
- [Atualização do sistema](#2-atualize-o-sistema)
- [Zsh + Oh My Zsh](#3-configure-zsh--oh-my-zsh)
- [Tema Powerlevel10k](#4-tema-moderno-com-powerlevel10k)
- [Alternativa: Starship (prompt)](#alternativa-starship-prompt)
- [Plugins do Zsh](#5-plugins-úteis-para-zsh)
- [FZF](#6-fzf-busca-interativa)
- [Node.js (fnm) + pnpm](#7-nodejs-com-fnm-fast-node-manager)
- [Java/Maven/Gradle (SDKMAN!)](#8-java-maven-e-gradle-com-sdkman)
- [Docker no WSL](#9-docker-no-wsl)
- [Extras recomendados](#10-extras-recomendados)
- [GitHub CLI e Chave SSH](#11-github-cli-e-chave-ssh)
- [Dicas de Fonte e Terminal](#dicas-de-fonte-e-terminal-windows)
- [Problemas Comuns (Troubleshooting)](#problemas-comuns-troubleshooting)
- [Resultado Final](#resultado-final)

## Pré-requisitos

[![Windows](https://img.shields.io/badge/Windows-WSL-0078D4?style=flat&logo=windows&logoColor=white)](https://learn.microsoft.com/windows/wsl/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%2B-E95420?style=flat&logo=ubuntu&logoColor=white)](https://ubuntu.com/wsl)
[![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-Recomendado-4D4D4D?style=flat&logo=windowsterminal&logoColor=white)](https://aka.ms/terminal)
[![Nerd Fonts](https://img.shields.io/badge/Nerd%20Fonts-Obrigatório-111?style=flat)](https://www.nerdfonts.com/)

- Windows 10/11 com suporte ao WSL
- Permissão de administrador para instalar o WSL e o Docker Desktop
- Windows Terminal (recomendado) instalado
- Fonte Nerd Font instalada no Windows (ex.: MesloLGS NF, JetBrainsMono)

## 1) Instale e configure o WSL (Ubuntu)

[![WSL](https://img.shields.io/badge/WSL-Enabled-0078D4?style=flat&logo=windows&logoColor=white)](https://learn.microsoft.com/windows/wsl/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-Linux-E95420?style=flat&logo=ubuntu&logoColor=white)](https://ubuntu.com/wsl)
[![PowerShell](https://img.shields.io/badge/PowerShell-Admin-5391FE?style=flat&logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)

No PowerShell como Administrador:

```powershell
wsl --install -d Ubuntu
```

Reinicie o PC, crie seu usuário Linux no primeiro login do Ubuntu e volte aqui.

## 2) Atualize o sistema

[![Ubuntu](https://img.shields.io/badge/Ubuntu-Update-E95420?style=flat&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![APT](https://img.shields.io/badge/APT-Upgrade-3D7EBB?style=flat)](https://wiki.debian.org/Apt)

No Ubuntu/WSL:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git unzip build-essential zip htop wget ca-certificates gnupg lsb-release
```

## 3) Configure Zsh + Oh My Zsh

[![Zsh](https://img.shields.io/badge/Zsh-Shell-FFD700?style=flat)](https://www.zsh.org/)
[![Oh My Zsh](https://img.shields.io/badge/Oh%20My%20Zsh-Framework-1A2C34?style=flat)](https://ohmyz.sh/)

```bash
sudo apt install -y zsh
chsh -s "$(which zsh)"

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Se o shell não trocar imediatamente, rode:

```bash
exec zsh
```

## 4) Tema moderno com Powerlevel10k

[![Powerlevel10k](https://img.shields.io/badge/Powerlevel10k-Theme-0ABDC6?style=flat)](https://github.com/romkatv/powerlevel10k)
[![Nerd Fonts](https://img.shields.io/badge/Nerd%20Fonts-Icons-111?style=flat)](https://www.nerdfonts.com/)

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

Edite `~/.zshrc` e defina o tema:

```bash
# Abra o arquivo
nano ~/.zshrc

# Altere a linha do tema
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Aplique:

```bash
# Opção 1
exec zsh

# Opção 2
source ~/.zshrc
```

O assistente do Powerlevel10k abrirá para configurar o visual.

<div align="right">

[⬆️ Voltar ao topo](#top)

</div>

---

### Alternativa: Starship (prompt)

[![Starship](https://img.shields.io/badge/Starship-Cross--Shell-7F52FF?style=flat&logo=starship&logoColor=white)](https://starship.rs/)

- Instale o Starship

```bash
curl -sS https://starship.rs/install.sh | sh
```

- Adicione aoo final do `~/.zshrc`:

```bash
eval "$(starship init zsh)"
```

- Crie a pasta de configurações:

```bash
mkdir -p ~/.config
nano ~/.config/starship.toml
```

- Cole a configuração básica(estilo Warp):

```bash
[aws]
symbol = "  "

[buf]
symbol = " "

[bun]
symbol = " "

[c]
symbol = " "

[cpp]
symbol = " "

[cmake]
symbol = " "

[conda]
symbol = " "

[crystal]
symbol = " "

[dart]
symbol = " "

[deno]
symbol = " "

[directory]
read_only = " 󰌾"

[docker_context]
symbol = " "

[elixir]
symbol = " "

[elm]
symbol = " "

[fennel]
symbol = " "

[fossil_branch]
symbol = " "

[gcloud]
symbol = "  "

[git_branch]
symbol = " "

[git_commit]
tag_symbol = '  '

[golang]
symbol = " "

[guix_shell]
symbol = " "

[haskell]
symbol = " "

[haxe]
symbol = " "

[hg_branch]
symbol = " "

[hostname]
ssh_symbol = " "

[java]
symbol = " "

[julia]
symbol = " "

[kotlin]
symbol = " "

[lua]
symbol = " "

[memory_usage]
symbol = "󰍛 "

[meson]
symbol = "󰔷 "

[nim]
symbol = "󰆥 "

[nix_shell]
symbol = " "

[nodejs]
symbol = " "

[ocaml]
symbol = " "

[os.symbols]
Alpaquita = " "
Alpine = " "
AlmaLinux = " "
Amazon = " "
Android = " "
Arch = " "
Artix = " "
CachyOS = " "
CentOS = " "
Debian = " "
DragonFly = " "
Emscripten = " "
EndeavourOS = " "
Fedora = " "
FreeBSD = " "
Garuda = "󰛓 "
Gentoo = " "
HardenedBSD = "󰞌 "
Illumos = "󰈸 "
Kali = " "
Linux = " "
Mabox = " "
Macos = " "
Manjaro = " "
Mariner = " "
MidnightBSD = " "
Mint = " "
NetBSD = " "
NixOS = " "
Nobara = " "
OpenBSD = "󰈺 "
openSUSE = " "
OracleLinux = "󰌷 "
Pop = " "
Raspbian = " "
Redhat = " "
RedHatEnterprise = " "
RockyLinux = " "
Redox = "󰀘 "
Solus = "󰠳 "
SUSE = " "
Ubuntu = " "
Unknown = " "
Void = " "
Windows = "󰍲 "

[package]
symbol = "󰏗 "

[perl]
symbol = " "

[php]
symbol = " "

[pijul_channel]
symbol = " "

[pixi]
symbol = "󰏗 "

[python]
symbol = " "

[rlang]
symbol = "󰟔 "

[ruby]
symbol = " "

[rust]
symbol = "󱘗 "

[scala]
symbol = " "

[swift]
symbol = " "

[zig]
symbol = " "

[gradle]
symbol = " "

```

---

## 5) Plugins úteis para Zsh

[![zsh-autosuggestions](https://img.shields.io/badge/zsh--autosuggestions-Plugin-10B981?style=flat)](https://github.com/zsh-users/zsh-autosuggestions)
[![zsh-syntax-highlighting](https://img.shields.io/badge/zsh--syntax--highlighting-Plugin-6366F1?style=flat)](https://github.com/zsh-users/zsh-syntax-highlighting)
[![zsh-autocomplete](https://img.shields.io/badge/zsh--autocomplete-Plugin-F59E0B?style=flat)](https://github.com/marlonrichert/zsh-autocomplete)

```bash
# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Autocomplete Inteligente
git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
```

Edite `~/.zshrc` e ajuste a linha de plugins (ordem recomendada):

```bash
# Abra o arquivo
nano ~/.zshrc

# Cole essa linha:
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)
```

Recarregue:

```bash
# Opção 1
exec zsh

# Opção 2
source ~/.zshrc
```

## 6) FZF (busca interativa)

[![fzf](https://img.shields.io/badge/fzf-Fuzzy%20Finder-23B5D3?style=flat)](https://github.com/junegunn/fzf)

```bash
sudo apt install -y fzf
```

<div align="right">

[⬆️ Voltar ao topo](#top)

</div>

## 7) Node.js com fnm (Fast Node Manager)

[![Node.js](https://img.shields.io/badge/Node.js-LTS-339933?style=flat&logo=node.js&logoColor=white)](https://nodejs.org/)
[![fnm](https://img.shields.io/badge/fnm-Node%20Manager-2E7D32?style=flat)](https://github.com/Schniz/fnm)
[![pnpm](https://img.shields.io/badge/pnpm-Enabled-F69220?style=flat&logo=pnpm&logoColor=white)](https://pnpm.io/)

```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

Adicione ao `~/.zshrc`:

```bash
eval "$(fnm env --use-on-cd)"
```

Recarregue o shell e instale a versão LTS:

```bash
exec zsh
fnm install --lts
fnm default lts-latest
node -v
npm -v
```

### pnpm (via Corepack)

```bash
corepack enable
corepack prepare pnpm@latest --activate
pnpm -v
```

Alternativa via npm:

```bash
npm install -g pnpm
pnpm -v
```

## 8) Java, Maven e Gradle com SDKMAN!

[![Java](https://img.shields.io/badge/Java-21-007396?style=flat&logo=java&logoColor=white)](https://adoptium.net/)
[![Maven](https://img.shields.io/badge/Maven-Build-C71A36?style=flat&logo=apachemaven&logoColor=white)](https://maven.apache.org/)
[![Gradle](https://img.shields.io/badge/Gradle-Build-02303A?style=flat&logo=gradle&logoColor=white)](https://gradle.org/)
[![SDKMAN](https://img.shields.io/badge/SDKMAN-Manager-34D399?style=flat)](https://sdkman.io/)

```bash
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java 21.0.5-tem
sdk install maven
sdk install gradle

java -version
mvn -v
gradle -v
```

## 9) Docker no WSL

[![Docker](https://img.shields.io/badge/Docker-Desktop-2496ED?style=flat&logo=docker&logoColor=white)](https://www.docker.com/products/docker-desktop/)
[![Docker CLI](https://img.shields.io/badge/Docker-CLI-2496ED?style=flat&logo=docker&logoColor=white)](https://docs.docker.com/engine/install/ubuntu/)
[![WSL Integration](https://img.shields.io/badge/WSL-Integration-0078D4?style=flat&logo=windows&logoColor=white)](https://docs.docker.com/desktop/wsl/)

### Opção 1: Docker Desktop + WSL Integration (Recomendado)

- Instale o Docker Desktop no Windows.
- Em Docker Desktop → Settings → Resources → WSL Integration, habilite seu Ubuntu.

No Ubuntu/WSL:

```bash
sudo groupadd docker || true
sudo usermod -aG docker "$USER"
newgrp docker

# Teste
docker run hello-world
```

### Opção 2: Instalar apenas o Docker CLI no WSL (Ubuntu)

Se preferir usar apenas o CLI do Docker no WSL conectado ao Docker Desktop:

#### 1. Atualize os pacotes

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
```

#### 2. Adicione o repositório oficial do Docker

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

#### 3. Instale somente o CLI

```bash
sudo apt-get install -y docker-ce-cli docker-compose-plugin
```

Isso instala:

- `docker` (CLI)
- `docker compose` (plugin moderno)

#### 4. Configure a conexão com o Docker Desktop

No Docker Desktop (Windows), certifique-se de:

- Ele está aberto e rodando
- O Ubuntu WSL está ativado em "Settings → Resources → WSL Integration"

Adicione seu usuário ao grupo docker:

```bash
sudo groupadd docker || true
sudo usermod -aG docker "$USER"
newgrp docker
```

#### 5. Teste a instalação

```bash
# Verifique a versão do Docker CLI
docker version

# Teste com um container
docker run hello-world

# Teste o Docker Compose
docker compose version
```

**Nota:** Com esta configuração, você usa o Docker CLI no WSL, mas o Docker Engine roda no Docker Desktop (Windows). Isso oferece melhor performance e integração.

## 10) Extras recomendados

[![bat](https://img.shields.io/badge/bat-Cat%20with%20wings-111?style=flat)](https://github.com/sharkdp/bat)
[![fd](https://img.shields.io/badge/fd-Fast%20Find-111?style=flat)](https://github.com/sharkdp/fd)
[![tree](https://img.shields.io/badge/tree-CLI-555?style=flat)](http://mama.indstate.edu/users/ice/tree/)
[![neofetch](https://img.shields.io/badge/neofetch-System%20Info-7755CC?style=flat)](https://github.com/dylanaraps/neofetch)

```bash
sudo apt install -y bat fd-find tree neofetch

# Ajustar nomes dos binários para comandos curtos
mkdir -p ~/.local/bin
ln -sf "$(which fdfind)" ~/.local/bin/fd
ln -sf "$(which batcat)" ~/.local/bin/bat
```

Garanta que `~/.local/bin` está no PATH (adicione ao `~/.zshrc` se necessário):

```bash
export PATH="$HOME/.local/bin:$PATH"
```


<div align="right">

[⬆️ Voltar ao topo](#top)

</div>


## 11) GitHub CLI e Chave SSH

[![GitHub CLI](https://img.shields.io/badge/GitHub%20CLI-gh-181717?style=flat&logo=github&logoColor=white)](https://cli.github.com/)
[![SSH](https://img.shields.io/badge/SSH-Keys-000?style=flat)](https://docs.github.com/authentication/connecting-to-github-with-ssh)

### Instalar GitHub CLI (gh)

```bash
type -p curl >/dev/null || sudo apt install -y curl
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install -y gh
```

### Configurar Git (global)

```bash
# Configure seu nome e email
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@exemplo.com"

# Sempre inicializar repositórios com a branch 'main'
git config --global init.defaultBranch main

# Não fazer rebase ao fazer pull
git config --global pull.rebase false

# Verifique as configurações
git config --list
```

### Gerar Chave SSH e adicionar no GitHub

```bash
ssh-keygen -t ed25519 -C "seu-email@exemplo.com"
# pressione Enter para aceitar o caminho padrão (~/.ssh/id_ed25519) e defina uma passphrase (opcional)

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copie a chave pública
cat ~/.ssh/id_ed25519.pub

# Abra as configurações do GitHub em: https://github.com/settings/keys
# Adicione uma nova SSH Key (cole o conteúdo acima)
```

### Autenticar no GitHub via gh

```bash
gh auth login
# Escolha: GitHub.com → SSH → Login via browser (ou device code)

# Teste de conexão SSH
ssh -T git@github.com
```

## Dicas de Fonte e Terminal (Windows)

[![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-Settings-4D4D4D?style=flat&logo=windowsterminal&logoColor=white)](https://aka.ms/terminal)
[![Nerd Fonts](https://img.shields.io/badge/Nerd%20Fonts-Setup-111?style=flat)](https://www.nerdfonts.com/)
[![VS Code](https://img.shields.io/badge/VS%20Code-WSL-007ACC?style=flat&logo=visualstudiocode&logoColor=white)](https://code.visualstudio.com/docs/remote/wsl)

- Instale uma Nerd Font (ex.: MesloLGS NF, JetBrainsMono Nerd Font) no Windows para ícones corretos.
- No Windows Terminal: defina a fonte da sua distro Ubuntu para a Nerd Font instalada.
- Se usar VS Code + WSL, configure a mesma fonte em `settings.json` (editor e integrated terminal).

## Problemas Comuns (Troubleshooting)

- Plugins sem efeito: confirme a linha `plugins=(...)` no `~/.zshrc` e rode `exec zsh`.
- Tema sem ícones: instale/seleciona Nerd Font no Windows Terminal.
- `docker` requer sudo: confirme que seu usuário está no grupo `docker` e que a integração WSL está ativa no Docker Desktop.
- `fnm` não encontrado após instalar: verifique se o trecho `eval "$(fnm env --use-on-cd)"` está no `~/.zshrc` e recarregue o shell.
- Binários `fd`/`bat` não encontrados: confirme que `~/.local/bin` está no PATH e que os links simbólicos existem.

## Resultado Final

- Terminal com Powerlevel10k (rápido e bonito)
- Zsh com Autosuggestions + Syntax Highlighting
- FZF para busca/auto-complete
- Node.js via fnm (gestão simples de versões)
- Java, Maven e Gradle via SDKMAN!
- Docker funcionando no WSL integrado ao Windows
- GitHub CLI instalado e configurado
- Utilitários extras (`bat`, `fd`, `tree`, `neofetch`, etc.)

## Dicas Úteis

- Use `p10k configure` a qualquer momento para reconfigurar o Powerlevel10k.
- Use `gh help` para ver comandos do GitHub CLI.
- Use `sdk list` para ver versões disponíveis no SDKMAN!.
- Use `docker --help` para ver comandos do Docker.
- use `fnm help` para ver comandos do fnm.
- Use `pnpm help` para ver comandos do pnpm.

- Rode o comando:

```bash
# Irá manter manter o sistema atualizado e limpo.
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean
```

## Minas Configurações do ZSH

- Ao final da instalação, configure o `~/.zshrc` conforme necessário.

```bash
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

```

---

<div align="right">

[⬆️ Voltar ao topo](#top)

</div>
