<div align="center" id="top">

<h1 align="center">🚀 Ambiente Dev no WSL (Ubuntu) – Guia Completo</h1>

[![Ambiente de Desenvolvimento](https://img.shields.io/badge/Ambiente-Desenvolvimento-6C63FF?style=for-the-badge)](#índice)
[![WSL](https://img.shields.io/badge/WSL-Enabled-0078D4?style=for-the-badge&logo=windows&logoColor=white)](https://learn.microsoft.com/windows/wsl/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-Linux-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/wsl)
[![Node.js](https://img.shields.io/badge/Node.js-Setup-339933?style=for-the-badge&logo=node.js&logoColor=white)](#7-nodejs-com-fnm-fast-node-manager)
[![Java](https://img.shields.io/badge/Java-SDKMAN-007396?style=for-the-badge&logo=java&logoColor=white)](#8-java-maven-e-gradle-com-sdkman)
[![PHP](https://img.shields.io/badge/PHP-Composer-777BB4?style=for-the-badge&logo=php&logoColor=white)](#9-php)
[![.NET](https://img.shields.io/badge/.NET-SDK-512BD4?style=for-the-badge&logo=.net&logoColor=white)](#10-c-net---instalação-e-configuração)
[![Docker](https://img.shields.io/badge/Docker-WSL-2496ED?style=for-the-badge&logo=docker&logoColor=white)](#11-docker-no-wsl)
[![Git](https://img.shields.io/badge/Git-Config-F05032?style=for-the-badge&logo=git&logoColor=white)](#configurar-git-global)
[![GitHub](https://img.shields.io/badge/GitHub-CLI-181717?style=for-the-badge&logo=github&logoColor=white)](#13-github-cli-e-chave-ssh)

Este guia configura um terminal moderno e produtivo no Windows via WSL (Ubuntu), com Zsh + Oh My Zsh, tema Powerlevel10k, plugins úteis, FZF, Node.js (fnm + pnpm), Java/Maven/Gradle (SDKMAN!), Docker integrado ao WSL e utilitários extras. Ao final, você terá um terminal rápido, bonito e pronto para desenvolvimento.

[![My Skills](https://skillicons.dev/icons?i=linux,ubuntu,python,java,maven,gradle,nodejs,npm,pnpm,cs,dotnet,php,docker,git,github&theme=dark)](https://skillicons.dev)

</div>

- Testado em: Windows 11 + WSL (Ubuntu)
- Shell: `zsh`

<img src="docs/images/terminal-wsl-ubuntu.png" alt="Resultado Final do Terminal" />

## Índice

### 📚 Guia Principal

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
- [PHP + Composer](#9-php)
- [.NET SDK](#10-net-sdk)
- [Docker no WSL](#11-docker-no-wsl)
- [Extras recomendados](#12-extras-recomendados)
- [GitHub CLI e Chave SSH](#13-github-cli-e-chave-ssh)
- [Dicas de Fonte e Terminal](#dicas-de-fonte-e-terminal-windows)
- [Problemas Comuns (Troubleshooting)](#problemas-comuns-troubleshooting)
- [Resultado Final](#resultado-final)
- [Dicas Úteis](#dicas-úteis)
- [Configuração do ZSH](#minhas-configurações-do-zsh)

### 📖 Documentação dos Scripts (`/docs`)

- [check-version.md](docs/check-version.md) - Verificar versões de ferramentas instaladas
- [docker-login.md](docs/docker-login.md) - Autenticação no Docker Hub
- [fastify-postgresql-script.md](docs/fastify-postgresql-script.md) - Criar API Fastify com PostgreSQL
- [git-push-faculdade.md](docs/git-push-faculdade.md) - Push para remote faculdade
- [git-push-origin.md](docs/git-push-origin.md) - Push para remote origin
- [install.md](docs/install.md) - Instalação automatizada do ambiente
- [next-shadcn-biome.md](docs/next-shadcn-biome.md) - Criar projeto Next.js com Biome
- [next-shadcn-prettierrc.md](docs/next-shadcn-prettierrc.md) - Criar projeto Next.js com Prettier
- [react-router-v7.md](docs/react-router-v7.md) - Criar projeto React Router v7
- [restart-docker.md](docs/restart-docker.md) - Reiniciar containers Docker
- [vscode-extensions-install.md](docs/vscode-extensions-install.md) - Instalar extensões VS Code

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

- Adicione ao final do `~/.zshrc`:

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
[![autojump](https://img.shields.io/badge/autojump-Directory%20Jump-orange?style=flat)](https://github.com/wting/autojump)

```bash
sudo apt install -y fzf autojump
```

> **Nota:** O `autojump` é usado na configuração de exemplo do `.zshrc`. Instale-o aqui para evitar erros futuros.

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

### Observações

- O SDKMAN! facilita a instalação e troca entre múltiplas versões do Java, Maven e Gradle.
- Use `sdk list java`, `sdk list maven` e `sdk list gradle` para ver versões disponíveis.

### Configuração para o Intelija IDEA (opcional):

- Para configurar a conexão do IntelliJ IDEA no Windows com o WSL, será necessário fazer o download do JetBrains Gateway no Windows:

```bash
https://www.jetbrains.com/remote-development/gateway/
```

## 9) Php

[![PHP](https://img.shields.io/badge/PHP-8.2-777BB4?style=flat&logo=php&logoColor=white)](https://www.php.net/)
[![Composer](https://img.shields.io/badge/Composer-Dependency%20Manager-888888?style=flat&logo=composer&logoColor=white)](https://getcomposer.org/)

### 1. Adicionar Repositório PPA do PHP

```bash
# Adicionar repositório Ondrej para versões mais recentes do PHP
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
```

### 2. Instalar PHP 8.3 (ou versão desejada)

```bash
# Instalar PHP CLI
sudo apt install -y php8.3-cli

# Instalar extensões mais comuns
sudo apt install -y \
  php8.3-curl \
  php8.3-mbstring \
  php8.3-xml \
  php8.3-zip \
  php8.3-mysql \
  php8.3-pgsql \
  php8.3-sqlite3 \
  php8.3-gd \
  php8.3-bcmath \
  php8.3-intl \
  php8.3-redis \
  php8.3-xdebug

# Verificar instalação
php -v

# Listar extensões instaladas
php -m
```

### 3. Instalar Composer (Gerenciador de Dependências)

```bash
# Baixar e instalar Composer (método mais robusto)
curl -sS https://getcomposer.org/installer | php -- --install-dir=/tmp
sudo mv /tmp/composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# Verificar instalação
composer --version
```

### 4. Configurar PHP

```bash
# Editar php.ini
sudo nano /etc/php/8.3/cli/php.ini

# Configurações recomendadas:
# memory_limit = 512M
# max_execution_time = 300
# upload_max_filesize = 100M
# post_max_size = 100M
```

### 5. Instalar Múltiplas Versões do PHP (Opcional)

```bash
# Instalar PHP 8.2
sudo apt install -y php8.2-cli php8.2-fpm

# Instalar PHP 8.1
sudo apt install -y php8.1-cli php8.1-fpm

# Alternar entre versões
sudo update-alternatives --config php
```

### 6. Ferramentas Úteis para PHP

```bash
# PHPUnit (Testing)
composer global require phpunit/phpunit

# PHP CS Fixer (Code Style)
composer global require friendsofphp/php-cs-fixer

# PHP CodeSniffer
composer global require squizlabs/php_codesniffer

# Adicionar Composer global ao PATH
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## 10) C# (.NET) - Instalação e Configuração

[![C#](https://img.shields.io/badge/C%23-239120?style=flat&logo=c-sharp&logoColor=white)](https://learn.microsoft.com/dotnet/csharp/)
[![.NET](https://img.shields.io/badge/.NET-512BD4?style=flat&logo=dotnet&logoColor=white)](https://dotnet.microsoft.com/)

### 1. Instalar .NET SDK (Método Recomendado via Microsoft)

```bash
# Baixar e adicionar chave de assinatura da Microsoft
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Atualizar repositórios
sudo apt update
```

### 2. Instalar .NET 8.0 SDK (LTS - Recomendado)

```bash
# Instalar .NET 8.0 SDK (inclui runtime)
sudo apt install -y dotnet-sdk-8.0

# Verificar instalação
dotnet --version
dotnet --list-sdks
dotnet --list-runtimes
```

### 3. Instalar Múltiplas Versões do .NET (Opcional)

```bash
# .NET 7.0
sudo apt install -y dotnet-sdk-7.0

# .NET 6.0 (LTS)
sudo apt install -y dotnet-sdk-6.0

# Verificar todas as versões instaladas
dotnet --list-sdks
```

### 4. Configurar Variáveis de Ambiente

```bash
# Adicionar ao ~/.zshrc
cat >> ~/.zshrc << 'EOF'

# .NET Configuration
export DOTNET_ROOT=/usr/share/dotnet
export PATH="$PATH:$DOTNET_ROOT:$HOME/.dotnet/tools"
export DOTNET_CLI_TELEMETRY_OPTOUT=1  # Desabilitar telemetria (opcional)
EOF

# Recarregar configuração
source ~/.zshrc
```

> **Nota:** Se o .NET estiver em outro local, verifique com `which dotnet` e ajuste o `DOTNET_ROOT` conforme necessário.

### 5. Ferramentas Globais do .NET

```bash
# Entity Framework Core Tools
dotnet tool install --global dotnet-ef

# ASP.NET Core Code Generator
dotnet tool install --global dotnet-aspnet-codegenerator

# User Secrets Manager
dotnet tool install --global dotnet-user-secrets

# Format (Code Formatter)
dotnet tool install --global dotnet-format

# Verificar ferramentas instaladas
dotnet tool list --global
```

## 11) Docker no WSL

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

> **⚠️ Importante:** O comando `newgrp docker` cria uma subshell temporária. Para aplicar permanentemente, feche o terminal e abra novamente, ou execute no PowerShell (Windows): `wsl --shutdown` e reabra o Ubuntu.

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

## 12) Extras recomendados

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

## 13) GitHub CLI e Chave SSH

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

## Validação da Instalação

[![Validation](https://img.shields.io/badge/Validation-Check-success?style=flat)]()

Após concluir todas as instalações, execute este script para validar:

```bash
echo "🔍 Validando instalações..."
echo "==========================================="
command -v zsh >/dev/null 2>&1 && echo "✅ Zsh instalado: $(zsh --version)" || echo "❌ Zsh não encontrado"
command -v fnm >/dev/null 2>&1 && echo "✅ fnm instalado: $(fnm --version)" || echo "❌ fnm não encontrado"
command -v node >/dev/null 2>&1 && echo "✅ Node.js instalado: $(node -v)" || echo "❌ Node.js não encontrado"
command -v pnpm >/dev/null 2>&1 && echo "✅ pnpm instalado: $(pnpm -v)" || echo "❌ pnpm não encontrado"
command -v java >/dev/null 2>&1 && echo "✅ Java instalado: $(java -version 2>&1 | head -n 1)" || echo "❌ Java não encontrado"
command -v mvn >/dev/null 2>&1 && echo "✅ Maven instalado: $(mvn -v | head -n 1)" || echo "❌ Maven não encontrado"
command -v gradle >/dev/null 2>&1 && echo "✅ Gradle instalado: $(gradle -v | grep Gradle)" || echo "❌ Gradle não encontrado"
command -v php >/dev/null 2>&1 && echo "✅ PHP instalado: $(php -v | head -n 1)" || echo "❌ PHP não encontrado"
command -v composer >/dev/null 2>&1 && echo "✅ Composer instalado: $(composer --version)" || echo "❌ Composer não encontrado"
command -v dotnet >/dev/null 2>&1 && echo "✅ .NET instalado: $(dotnet --version)" || echo "❌ .NET não encontrado"
command -v docker >/dev/null 2>&1 && echo "✅ Docker instalado: $(docker --version)" || echo "❌ Docker não encontrado"
command -v gh >/dev/null 2>&1 && echo "✅ GitHub CLI instalado: $(gh --version | head -n 1)" || echo "❌ GitHub CLI não encontrado"
command -v bat >/dev/null 2>&1 && echo "✅ bat instalado" || echo "❌ bat não encontrado"
command -v fd >/dev/null 2>&1 && echo "✅ fd instalado" || echo "❌ fd não encontrado"
echo "==========================================="
echo "✨ Validação concluída!"
```

### Validar Versão do WSL

Certifique-se de estar usando **WSL 2** para melhor performance:

```powershell
# Execute no PowerShell (Windows)
wsl -l -v
```

Se estiver usando WSL 1, converta para WSL 2:

```powershell
# Execute no PowerShell como Administrador
wsl --set-version Ubuntu 2
```

## Dicas de Fonte e Terminal (Windows)

[![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-Settings-4D4D4D?style=flat&logo=windowsterminal&logoColor=white)](https://aka.ms/terminal)
[![Nerd Fonts](https://img.shields.io/badge/Nerd%20Fonts-Setup-111?style=flat)](https://www.nerdfonts.com/)
[![VS Code](https://img.shields.io/badge/VS%20Code-WSL-007ACC?style=flat&logo=visualstudiocode&logoColor=white)](https://code.visualstudio.com/docs/remote/wsl)

- Instale uma Nerd Font (ex.: MesloLGS NF, JetBrainsMono Nerd Font) no Windows para ícones corretos.
- No Windows Terminal: defina a fonte da sua distro Ubuntu para a Nerd Font instalada.
- Se usar VS Code + WSL, configure a mesma fonte em `settings.json` (editor e integrated terminal).

## Problemas Comuns (Troubleshooting)

### 🔧 Plugins Zsh sem efeito

- **Sintoma:** Autosuggestions ou syntax highlighting não funcionam
- **Solução:**
  ```bash
  # Verifique a linha plugins no ~/.zshrc
  grep "plugins=" ~/.zshrc
  # Recarregue o shell
  exec zsh
  ```

### 🎨 Tema sem ícones

- **Sintoma:** Caracteres quebrados ou quadrados no prompt
- **Solução:** Instale uma Nerd Font (MesloLGS NF ou JetBrainsMono) no Windows e configure no Windows Terminal

### 🐳 Docker requer sudo

- **Sintoma:** `permission denied while trying to connect to the Docker daemon socket`
- **Solução:**
  ```bash
  # Adicione usuário ao grupo docker
  sudo usermod -aG docker $USER
  # Feche e reabra o terminal ou reinicie o WSL
  # No PowerShell (Windows):
  wsl --shutdown
  # Reabra o Ubuntu
  ```

### 📦 fnm não encontrado

- **Sintoma:** `command not found: fnm`
- **Solução:**
  ```bash
  # Verifique se está no ~/.zshrc
  grep "fnm env" ~/.zshrc
  # Se não estiver, adicione:
  echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
  source ~/.zshrc
  ```

### 🔍 Binários fd/bat não encontrados

- **Sintoma:** `command not found: fd` ou `command not found: bat`
- **Solução:**
  ```bash
  # Verifique os links simbólicos
  ls -la ~/.local/bin/{fd,bat}
  # Recrie se necessário
  mkdir -p ~/.local/bin
  ln -sf "$(which fdfind)" ~/.local/bin/fd
  ln -sf "$(which batcat)" ~/.local/bin/bat
  # Verifique o PATH
  echo $PATH | grep ".local/bin"
  ```

### ⚙️ .NET não encontrado

- **Sintoma:** `command not found: dotnet`
- **Solução:**
  ```bash
  # Verifique a instalação
  which dotnet
  # Se instalado mas não no PATH, adicione:
  export PATH="$PATH:/usr/share/dotnet"
  # Torne permanente no ~/.zshrc
  echo 'export PATH="$PATH:/usr/share/dotnet"' >> ~/.zshrc
  ```

### 🐘 PHP ou Composer com problemas

- **Sintoma:** Versão errada do PHP ou composer não encontrado
- **Solução:**
  ```bash
  # Listar versões instaladas do PHP
  update-alternatives --list php
  # Alternar versão
  sudo update-alternatives --config php
  # Verificar Composer
  which composer
  composer --version
  ```

## Resultado Final

- Terminal com Powerlevel10k (rápido e bonito)
- Zsh com Autosuggestions + Syntax Highlighting
- FZF para busca/auto-complete
- Node.js via fnm (gestão simples de versões)
- Java, Maven e Gradle via SDKMAN!
- Php 8.3 + Composer
- .NET SDK via pacotes oficiais da Microsoft
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

## Minhas Configurações do ZSH

### Configuração do ~/.zshrc

Ao final da instalação, configure o `~/.zshrc` conforme necessário:

> **⚠️ Nota sobre o exemplo abaixo:** Esta configuração inclui setup para **Bun** (runtime JavaScript), **Pyenv** (gerenciador de versões Python) e **Autojump** que não estão cobertos nas seções anteriores. Se você não instalou essas ferramentas, pode remover ou comentar as respectivas seções.

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

# --- Java (WSL + Gradle + SDKMAN) ---
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

```

## Scripts Disponíveis em `/src`

Este repositório inclui diversos scripts bash para automatizar tarefas comuns de desenvolvimento. Abaixo estão as instruções de uso:

#### 🔍 Verificar Versões das Ferramentas

```bash
./src/check-version.sh
```

Exibe as versões instaladas de Java, Node.js, Python, Docker, PHP, .NET e outras ferramentas de desenvolvimento.

📖 **Documentação completa:** [docs/check-version.md](docs/check-version.md)

---

#### 🐳 Autenticação no Docker Hub

```bash
./src/docker-login.sh
```

Realiza login no Docker Hub e exibe informações sobre containers e imagens.

📖 **Documentação completa:** [docs/docker-login.md](docs/docker-login.md)

---

#### ⚡ Criar API Fastify com PostgreSQL

```bash
./src/fastify-postgresql-script.sh
```

Cria um projeto completo de API REST com Fastify, TypeScript, PostgreSQL, PgAdmin, Docker e Drizzle ORM.

📖 **Documentação completa:** [docs/fastify-postgresql-script.md](docs/fastify-postgresql-script.md)

---

#### 📤 Git Push Automatizado

```bash
# Push para remote 'origin'
./src/git-push-origin.sh

# Push para remote 'faculdade'
./src/git-push-faculdade.sh
```

Automatiza o processo de `git add`, `commit` e `push` com detecção automática da branch.

📖 **Documentação completa:**

- [docs/git-push-origin.md](docs/git-push-origin.md)
- [docs/git-push-faculdade.md](docs/git-push-faculdade.md)

---

#### 🎨 Criar Projeto Next.js com Shadcn UI

```bash
# Com Biome (linter/formatter moderno)
./src/next-shadcn-biome.sh

# Com Prettier + ESLint (tradicional)
./src/next-shadcn-prettierrc.sh
```

Cria projeto Next.js configurado com TypeScript, Tailwind CSS, Shadcn UI e opção de linter.

📖 **Documentação completa:**

- [docs/next-shadcn-biome.md](docs/next-shadcn-biome.md)
- [docs/next-shadcn-prettierrc.md](docs/next-shadcn-prettierrc.md)

---

#### ⚛️ Criar Projeto React Router v7

```bash
./src/react-router-v7.sh
```

Cria projeto React com Vite, TypeScript, React Router v7, Tailwind CSS, ESLint e Prettier.

📖 **Documentação completa:** [docs/react-router-v7.md](docs/react-router-v7.md)

---

#### 🔄 Reiniciar Containers Docker

```bash
./src/restart-docker.sh
```

Para containers, reconstrói imagens e exibe logs em tempo real.

📖 **Documentação completa:** [docs/restart-docker.md](docs/restart-docker.md)

---

#### 🧩 Instalar Extensões do VS Code

```bash
./src/vscode-extensions-install.sh
```

Instala extensões do VS Code a partir de um arquivo `vscode-extensions.txt`.

📖 **Documentação completa:** [docs/vscode-extensions-install.md](docs/vscode-extensions-install.md)

---

#### 🚀 Instalação Automatizada do Ambiente

```bash
./src/install.sh
```

Script completo que instala e configura automaticamente todo o ambiente de desenvolvimento (Zsh, Oh My Zsh, Powerlevel10k, Node.js, Java, Docker, etc.).

📖 **Documentação completa:** [docs/install.md](docs/install.md)

---

### 📋 Como Configurar os Aliases

Para facilitar o uso dos scripts, você pode adicionar aliases no seu `~/.zshrc`:

```bash
# Copiar scripts para ~/bin
mkdir -p ~/bin
cp src/*.sh ~/bin/
chmod +x ~/bin/*.sh

# Adicionar aliases no ~/.zshrc
cat >> ~/.zshrc << 'EOF'

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
EOF

# Recarregar configuração
source ~/.zshrc
```

Depois de configurar os aliases, você pode executar os scripts simplesmente digitando o alias:

```bash
versions                    # Verifica versões das ferramentas
docker-login               # Login no Docker Hub
create-fastify-app         # Cria API Fastify
git-push-origin            # Git push para origin
next-shadcn-biome          # Cria projeto Next.js com Biome
react-router-v7            # Cria projeto React Router
restart-docker             # Reinicia containers Docker
```

---

<div align="right">

[⬆️ Voltar ao topo](#top)

</div>
