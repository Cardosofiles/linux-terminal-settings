<div align="center" id="top">

<h1 align="center">🐧 Ambiente Dev no Ubuntu 26.04 LTS (nativo) – Guia Completo</h1>

[![Ubuntu](https://img.shields.io/badge/Ubuntu-26.04%20LTS-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/download/desktop)
[![Bare Metal](https://img.shields.io/badge/Bare%20Metal-Sem%20WSL-111?style=for-the-badge)](#top)
[![Node.js](https://img.shields.io/badge/Node.js-fnm-339933?style=for-the-badge&logo=node.js&logoColor=white)](#7-nodejs-com-fnm)
[![Java](https://img.shields.io/badge/Java-SDKMAN-007396?style=for-the-badge&logo=java&logoColor=white)](#8-java-maven-e-gradle-com-sdkman)
[![PHP](https://img.shields.io/badge/PHP-8.5%20nativo-777BB4?style=for-the-badge&logo=php&logoColor=white)](#9-php-85)
[![.NET](https://img.shields.io/badge/.NET-10%20LTS-512BD4?style=for-the-badge&logo=.net&logoColor=white)](#10-c-net)
[![Docker](https://img.shields.io/badge/Docker-Engine-2496ED?style=for-the-badge&logo=docker&logoColor=white)](#11-docker-engine)

Versão deste guia para **instalação limpa do Ubuntu Desktop 26.04 LTS "Resolute Raccoon"** em hardware real — sem Windows, sem WSL.
O guia original ([`README.md`](README.md)) continua válido para WSL2; este arquivo corrige tudo o que **não se aplica** ou **quebra** fora do WSL.

</div>

---

- Alvo: **Ubuntu 26.04 LTS (`resolute`)**, desktop, instalação limpa
- Shell: `zsh` + Oh My Zsh + Powerlevel10k
- Terminal padrão do 26.04: **Ptyxis** (substituiu o GNOME Terminal)
- Disponibilidade dos pacotes conferida no índice `resolute` em 31/08/2026

> **Se você instalar o 24.04 LTS em vez do 26.04**, veja a [tabela de divergências entre releases](#anexo-b--diferenças-24.04-vs-26.04) no fim do arquivo. As diferenças estão concentradas em 3 pontos: PHP, `fastfetch` e coreutils.

## Índice

- [O que muda em relação ao guia WSL](#o-que-muda-em-relação-ao-guia-wsl)
- [0. Pós-instalação do Ubuntu](#0-pós-instalação-do-ubuntu)
- [1. Terminal e Nerd Font (no Linux)](#1-terminal-e-nerd-font-no-linux)
- [2. Atualização do sistema](#2-atualize-o-sistema)
  - [2.1 Debloat seguro para desktop](#21-debloat-seguro-para-desktop)
  - [2.2 Novidades do 26.04 que afetam scripts](#22-novidades-do-2604-que-afetam-scripts)
- [3. Zsh + Oh My Zsh](#3-configure-zsh--oh-my-zsh)
- [4. Powerlevel10k](#4-tema-moderno-com-powerlevel10k)
- [5. Plugins do Zsh](#5-plugins-úteis-para-zsh)
- [6. FZF e autojump](#6-fzf-e-autojump)
- [7. Node.js com fnm](#7-nodejs-com-fnm)
- [8. Java, Maven e Gradle com SDKMAN!](#8-java-maven-e-gradle-com-sdkman)
- [9. PHP 8.5](#9-php-85)
- [10. C# (.NET)](#10-c-net)
- [11. Docker Engine](#11-docker-engine)
- [12. Extras recomendados](#12-extras-recomendados)
- [13. GitHub CLI e chave SSH](#13-github-cli-e-chave-ssh)
- [14. Apps de desenvolvimento (nativos)](#14-apps-de-desenvolvimento-nativos)
- [Validação da instalação](#validação-da-instalação)
- [Troubleshooting](#troubleshooting)
- [~/.zshrc para Ubuntu nativo](#zshrc-para-ubuntu-nativo)
- [Scripts do repositório: o que quebra fora do WSL](#scripts-do-repositório-o-que-quebra-fora-do-wsl)
- [Anexo A – Remover o snap (só se você realmente quiser)](#anexo-a--remover-o-snap-só-se-você-realmente-quiser)
- [Anexo B – Diferenças 24.04 vs 26.04](#anexo-b--diferenças-2404-vs-2604)

---

## O que muda em relação ao guia WSL

Resumo da auditoria do `README.md` contra uma instalação nativa. **Verificado**, não estimado.

| # | Seção do guia WSL | Status no Ubuntu nativo | Ação |
|---|---|---|---|
| — | Pré-requisitos (Windows Terminal, fonte no Windows) | ❌ Não se aplica | Fonte instalada **no Linux** → [passo 1](#1-terminal-e-nerd-font-no-linux) |
| 1 | `wsl --install`, `wsl --update` | ❌ Não existe | Removido |
| 1.1 | `.wslconfig`, `autoMemoryReclaim`, `vmmem` | ❌ Não existe | Removido — a RAM é gerenciada pelo kernel |
| 2 | `apt install ...` | ✅ Igual | Mantido (+ `wl-clipboard`) |
| 2.1 | `/etc/wsl.conf` + `[boot] systemd=true` | ❌ Não existe | Removido — systemd já é PID 1 |
| 2.1 | `apt purge snapd` + `rm -rf /snap` | 🔴 **PERIGOSO** | **Não faça.** Quebra Firefox, App Center e firmware-updater → [Anexo A](#anexo-a--remover-o-snap-só-se-você-realmente-quiser) |
| 2.1 | Desabilitar mysql/apache2/nginx/redis | ✅ Inofensivo | Mantido |
| 3–5 | Zsh, Oh My Zsh, P10k, plugins | ✅ Igual | Mantido (nota sobre logout no `chsh`) |
| 6 | `fzf` + `autojump` | ✅ Ambos existem no `resolute` | Mantido |
| 7 | `fnm` + `corepack` | ✅ Igual | Mantido |
| 8 | SDKMAN | ✅ Igual | Mantido |
| 8 | JetBrains Gateway p/ conectar IntelliJ do Windows | ❌ Não se aplica | IntelliJ roda nativo → [passo 14](#14-apps-de-desenvolvimento-nativos) |
| 9 | `ppa:ondrej/php` + `PHP_V=8.4` | 🔴 **QUEBRA** | O PPA **não publica para `resolute`** e `php8.4-cli` não existe. O 26.04 traz **PHP 8.5 nativo** → [passo 9](#9-php-85) |
| 10 | `dotnet-sdk-10.0` do feed do Ubuntu | ✅ Confirmado (`10.0.111-0ubuntu1~26.04.1`) | Mantido |
| 11 | Docker Engine via `download.docker.com` | ✅ Suite `resolute` publicada | Mantido (remove menções a Docker Desktop) |
| 12 | `neofetch` | 🔴 **QUEBRA** | Removido do Ubuntu desde o 25.04. Use **`fastfetch`** (`2.57.1` no `resolute`) |
| 13 | `gh` via `cli.github.com/packages stable main` | ✅ Repo é *flat*, independe da suite | Mantido |
| 13 | `ssh-agent` manual | ⚠️ Parcial | O GNOME Keyring já expõe um agent; o guard do `.zshrc` cobre isso |
| — | `alias cursor="/mnt/c/Users/..."`, `idea()` com `/mnt/c` | 🔴 **QUEBRA** | Substituídos por instalações nativas → [passo 14](#14-apps-de-desenvolvimento-nativos) |
| — | `export TERM="xterm-256color"` | ⚠️ Contraproducente | Remova: o Ptyxis/kitty/wezterm já anunciam um `TERM` melhor |
| — | Troubleshooting com `wsl --shutdown` | ❌ Não se aplica | Trocado por logout/login |
| — | `src/idea.sh` (`wslpath`, `cmd.exe`) | 🔴 **QUEBRA** | → [seção de scripts](#scripts-do-repositório-o-que-quebra-fora-do-wsl) |
| — | `src/install.sh` (`require_wsl_ubuntu`) | ⚠️ Roda, mas orienta errado | Idem |
| — | `src/dev-machine-setup.sh` (sobrescreve `/etc/wsl.conf`) | 🔴 **QUEBRA** | Idem |

<div align="right"><a href="#top">⬆️ Voltar ao topo</a></div>

---

## 0) Pós-instalação do Ubuntu

Logo depois do primeiro boot, antes de qualquer coisa:

```bash
sudo apt update && sudo apt full-upgrade -y
sudo reboot
```

Drivers proprietários (placa de vídeo NVIDIA, Wi-Fi, etc.):

```bash
# Lista o que o Ubuntu detectou e recomenda para o seu hardware
ubuntu-drivers list

# Instala o driver recomendado (ou use "Drivers Adicionais" na GUI)
sudo ubuntu-drivers install
```

Codecs e fontes da Microsoft (opcional — abre um diálogo de licença EULA):

```bash
sudo apt install -y ubuntu-restricted-extras
```

Firewall (recomendado em máquina de trabalho — desligado por padrão no Ubuntu):

```bash
sudo ufw enable
sudo ufw status verbose
```

> **Nada de `.wslconfig` aqui.** Em instalação nativa o kernel gerencia RAM e swap direto; não existe `vmmem` nem VM intermediária para "devolver" memória. O instalador do 26.04 cria um swapfile automaticamente — confira com `swapon --show`.

## 1) Terminal e Nerd Font (no Linux)

Esta é a maior diferença prática em relação ao WSL: **a fonte precisa ser instalada no Linux**, não no Windows.

### 1.1 Instalar uma Nerd Font

```bash
sudo apt install -y unzip fontconfig
mkdir -p ~/.local/share/fonts

cd /tmp
# MesloLGS é a fonte recomendada pelo Powerlevel10k
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip -o Meslo.zip -d ~/.local/share/fonts/Meslo

# (opcional) JetBrains Mono com os glifos do Nerd Fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono

fc-cache -fv
rm -f /tmp/Meslo.zip /tmp/JetBrainsMono.zip

# Confirme que o sistema enxerga a fonte
fc-list | grep -i "MesloLGS"
```

> ⚠️ **Não use `apt install fonts-jetbrains-mono` para isso.** Esse pacote traz a JetBrains Mono *original*, **sem** os glifos do Nerd Fonts — o Powerlevel10k vai continuar mostrando quadradinhos. Os ícones só vêm nos `.ttf` *patched* do repositório `ryanoasis/nerd-fonts` baixados acima.

### 1.2 Configurar o terminal

No Ubuntu 26.04 o terminal padrão é o **Ptyxis** (o GNOME Terminal foi aposentado). Pelo app:

`Ptyxis → menu ☰ → Preferences → Profiles → (seu perfil) → Font` → desmarque *Use system font* e escolha **MesloLGS Nerd Font**, tamanho 12.

Se preferir descobrir as chaves por CLI:

```bash
gsettings list-recursively | grep -i ptyxis | grep -iE 'font|profile' | head
```

<details>
<summary>Prefere outro terminal? (kitty, Alacritty, WezTerm)</summary>

```bash
sudo apt install -y kitty        # ou: alacritty / wezterm
```

Configuração mínima do kitty em `~/.config/kitty/kitty.conf`:

```conf
font_family      MesloLGS Nerd Font
font_size        12.0
```

Para definir como terminal padrão do GNOME (o atalho `Ctrl+Alt+T`):

```bash
gsettings set org.gnome.desktop.default-applications.terminal exec kitty
```

</details>

<div align="right"><a href="#top">⬆️ Voltar ao topo</a></div>

## 2) Atualize o sistema

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git unzip zip build-essential htop wget \
  ca-certificates gnupg lsb-release software-properties-common \
  wl-clipboard xclip
```

> `wl-clipboard` fornece `wl-copy`/`wl-paste` (Wayland, que é o padrão do Ubuntu 26.04). É o substituto do `clip.exe` que você usava no WSL. O `xclip` fica como fallback para sessões X11/XWayland.
>
> O guia WSL incluía `apt-transport-https` — hoje é um pacote de transição vazio (o APT fala HTTPS nativamente desde a versão 1.5). Pode omitir sem prejuízo.

### 2.1) Debloat seguro para desktop

> 🔴 **Não copie o bloco de debloat do guia WSL para cá.** Duas partes daquele passo são inválidas ou destrutivas em desktop nativo:
>
> 1. **`/etc/wsl.conf` + `[boot] systemd=true`** — esse arquivo não existe e não tem função fora do WSL. Em instalação nativa o `systemd` já é o PID 1. Pule inteiramente.
> 2. **`apt purge snapd` + `rm -rf /snap /var/snap /var/lib/snapd`** — no **Ubuntu Desktop** isso remove junto o **Firefox**, o **App Center**, o **firmware-updater** e o **Desktop Security Center**, que são todos snaps. No WSL (sem GUI) era inofensivo; aqui você fica sem navegador. Se ainda assim quiser sair do snap, siga o [Anexo A](#anexo-a--remover-o-snap-só-se-você-realmente-quiser), que instala o Firefox `.deb` **antes** de remover.

O que **é** seguro e vale a pena em uma máquina de desenvolvimento:

```bash
# 1) Relatórios de crash (não servem para nada em desktop de dev e rodam em background)
sudo systemctl disable --now apport.service 2>/dev/null || true
sudo apt purge -y apport whoopsie

# 2) Telemetria de instalação e censo de popularidade de pacotes
sudo apt purge -y ubuntu-report popularity-contest 2>/dev/null || true

# 3) Serviços de banco/web nativos (use Docker para isso!)
for svc in mysql mariadb apache2 nginx redis-server; do
    sudo systemctl disable --now "$svc" 2>/dev/null || true
done

sudo apt autoremove -y && sudo apt autoclean
```

<details>
<summary>Opcional: desligar a indexação de arquivos do GNOME (ganho real de RAM/CPU)</summary>

No GNOME 50 o indexador se chama `localsearch` (era `tracker-miner-fs`). Ele reindexa `~` em background — inútil se você busca com `fzf`/`fd`, e caro se você tem `node_modules` espalhado pelo disco.

```bash
# Descubra os nomes exatos das units na sua máquina antes de mascarar
systemctl --user list-unit-files | grep -Ei 'localsearch|tracker'

# Mascare o que aparecer (ajuste os nomes conforme a saída acima)
systemctl --user mask localsearch-3.service localsearch-writeback-3.service 2>/dev/null || true
```

Reversível a qualquer momento com `systemctl --user unmask <unit>`.

</details>

> ⚠️ **Não remova o `unattended-upgrades`.** Ele é o que aplica correções de segurança automaticamente. Em máquina de trabalho isso é proteção, não bloat.

### 2.2) Novidades do 26.04 que afetam scripts

O 26.04 trocou duas peças que estavam estáveis há décadas. Nada disso impede o setup, mas vale saber **antes** de debugar um script à toa:

**`rust-coreutils` (uutils) virou o padrão.** Cerca de 80 utilitários (`ls`, `cat`, `head`, `tail`, `wc`, `ln`, `mkdir`, `touch`, `chmod`, `chown`, `du`, `tr`…) agora são binários Rust. `cp`, `mv` e `rm` continuam sendo os do GNU. A compatibilidade é boa, mas flags exóticas do GNU podem faltar.

```bash
# Se um script quebrar com "unexpected argument" em um comando básico:
ls --version | head -1     # mostra se é uutils ou GNU coreutils

# Voltar para o GNU coreutils como padrão, se precisar:
sudo apt install -y coreutils
```

**`sudo` agora é o `sudo-rs`.** Reescrita em Rust, cobre o uso cotidiano (`sudo cmd`, `-u`, `-i`, `-E`, `sudoers`), mas não implementa 100% das opções do `sudo` original.

```bash
sudo --version   # identifica qual implementação está ativa

# Fallback para o sudo tradicional, se algum fluxo específico exigir:
sudo apt install -y sudo
```

> Todos os comandos deste guia foram escritos para funcionar nas duas implementações.

<div align="right"><a href="#top">⬆️ Voltar ao topo</a></div>

## 3) Configure Zsh + Oh My Zsh

```bash
sudo apt install -y zsh
chsh -s "$(command -v zsh)"

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

> **Diferença em relação ao WSL:** aqui o `chsh` só passa a valer no **próximo login gráfico**. Faça logout/login (ou reinicie) para que o terminal abra o zsh sozinho. Para testar na hora, `exec zsh`.
>
> Confira com `getent passwd "$USER" | cut -d: -f7` — deve responder `/usr/bin/zsh`.

## 4) Tema moderno com Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

Edite `~/.zshrc` e defina `ZSH_THEME="powerlevel10k/powerlevel10k"`. Recarregue com `exec zsh` para abrir o assistente.

O assistente vai perguntar se você enxerga alguns ícones. Se a resposta for "não", volte ao [passo 1.1](#11-instalar-uma-nerd-font) — a fonte não está aplicada no perfil do terminal.

## 5) Plugins úteis para Zsh

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

```bash
plugins=(
  git
  autojump
  fzf
  history-substring-search
  zsh-autosuggestions
  zsh-syntax-highlighting   # precisa ser SEMPRE o último da lista
)
```

> **⚠️ A ordem importa:** o `zsh-syntax-highlighting` envolve os widgets já registrados; qualquer plugin carregado depois dele fica sem realce.

## 6) FZF e autojump

```bash
sudo apt install -y fzf autojump
```

Ambos existem no `resolute` (`fzf`, `autojump 22.5.1`). Os plugins do passo 5 ativam `Ctrl+R` (histórico), `Ctrl+T` (arquivos) e `j <pasta>`.

<details>
<summary>Alternativa moderna ao autojump: zoxide</summary>

O `autojump` está em modo de manutenção há anos. O `zoxide` é o sucessor de facto, mais rápido e ativamente mantido:

```bash
sudo apt install -y zoxide
```

No `~/.zshrc` (e remova `autojump` da lista de plugins):

```bash
eval "$(zoxide init zsh --cmd j)"   # --cmd j mantém o mesmo atalho "j <pasta>"
```

</details>

## 7) Node.js com fnm

```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

Confira se o `~/.zshrc` recebeu a linha; se não, adicione:

```bash
eval "$(fnm env --use-on-cd --shell zsh)"
```

> `--use-on-cd` é o que troca a versão automaticamente ao entrar numa pasta com `.nvmrc` ou `.node-version`.

```bash
exec zsh
fnm install --lts
fnm default lts-latest

corepack enable
corepack install -g pnpm@latest
```

## 8) Java, Maven e Gradle com SDKMAN!

```bash
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk list java          # veja os identificadores disponíveis
sdk install java       # sem argumento: versão recomendada pelo SDKMAN
sdk install maven
sdk install gradle
```

Confirme que o `~/.zshrc` tem o init (o instalador escreve em `.bashrc` e `.zshrc`):

```bash
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
```

> **Diferença em relação ao WSL:** esqueça o JetBrains Gateway. Aqui o IntelliJ roda nativo no Linux e enxerga o `JAVA_HOME` do SDKMAN direto — veja o [passo 14](#14-apps-de-desenvolvimento-nativos).

## 9) PHP 8.5

> 🔴 **Mudança obrigatória em relação ao guia WSL.** Lá o passo era `add-apt-repository ppa:ondrej/php` + `PHP_V=8.4`. No 26.04 isso **falha duas vezes**: o PPA do Ondřej **não publica para `resolute`** (o Launchpad só lista `noble` e `jammy`), e `php8.4-cli` **não existe** no índice do 26.04.
>
> A boa notícia: **não precisa de repositório externo.** O Ubuntu 26.04 já traz **PHP 8.5.4** no repositório oficial.

```bash
# Confirme o que o feed nativo oferece
apt-cache policy php8.5-cli

PHP_V=8.5
sudo apt install -y php${PHP_V}-cli php${PHP_V}-curl php${PHP_V}-mbstring php${PHP_V}-xml \
  php${PHP_V}-zip php${PHP_V}-mysql php${PHP_V}-pgsql php${PHP_V}-sqlite3 php${PHP_V}-gd \
  php${PHP_V}-bcmath php${PHP_V}-intl php${PHP_V}-redis php${PHP_V}-xdebug

php -v
```

Composer:

```bash
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm /tmp/composer-setup.php
composer --version
```

<details>
<summary>Precisa de uma versão de PHP diferente da 8.5 (projeto legado)?</summary>

Use o repositório oficial do mantenedor — `packages.sury.org`, que **tem** suite `resolute` —, não o PPA do Launchpad:

```bash
sudo apt install -y ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(. /etc/os-release && echo "$VERSION_CODENAME") main" \
  | sudo tee /etc/apt/sources.list.d/sury-php.list > /dev/null
sudo apt update

apt-cache search --names-only '^php[0-9]\.[0-9]+-cli$'
```

Misturar o sury com o feed nativo pode gerar conflito de dependências. Só adicione se realmente precisar de outra versão.

</details>

<div align="right"><a href="#top">⬆️ Voltar ao topo</a></div>

## 10) C# (.NET)

> **⚠️ Não adicione o repositório da Microsoft.** O .NET vem no repositório **oficial do Ubuntu**. Instalar também o `packages-microsoft-prod.deb` faz os dois feeds publicarem os mesmos pacotes — conflito de dependências e o clássico `Unable to locate package dotnet-sdk-X`.

```bash
# Confirmado no índice do 26.04: dotnet-sdk-10.0 = 10.0.111-0ubuntu1~26.04.1
apt-cache policy dotnet-sdk-10.0

sudo apt update
sudo apt install -y dotnet-sdk-10.0   # LTS atual; use dotnet-sdk-8.0 só se o projeto exigir

dotnet --info
```

Com o pacote da distro o SDK fica em `/usr/lib/dotnet` e o `DOTNET_ROOT` **não precisa ser definido**. No `~/.zshrc`, apenas:

```bash
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export PATH="$PATH:$HOME/.dotnet/tools"
```

Se alguma ferramenta exigir `DOTNET_ROOT`, derive do binário real:

```bash
export DOTNET_ROOT="$(dirname "$(readlink -f "$(command -v dotnet)")")"
```

## 11) Docker Engine

Os comandos são **os mesmos do guia WSL** — o `download.docker.com` publica a suite `resolute`. O que muda é o contexto: não há Docker Desktop para desinstalar, e o `systemd` já está ativo desde o boot.

### 1. Remova instalações antigas e adicione o repositório

```bash
# Lista completa dos pacotes conflitantes segundo a documentação oficial
for pkg in docker.io docker-doc docker-compose docker-compose-v2 \
           podman-docker containerd runc; do
  sudo apt-get remove -y "$pkg" 2>/dev/null || true
done

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

> Não substitua `$VERSION_CODENAME` por um valor fixo. No 26.04 ele vale `resolute` — e é exatamente essa a suite publicada pelo Docker.

### 2. Instale o Docker Engine

```bash
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 3. Habilite o serviço e ajuste permissões

```bash
sudo systemctl enable --now docker

sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker "$USER"
```

**⚠️ Importante:** diferente do WSL (onde bastava `wsl --shutdown`), aqui o grupo só entra em vigor num **novo login**. Faça logout/login — ou, para testar imediatamente na sessão atual:

```bash
newgrp docker
docker run --rm hello-world
docker compose version
```

## 12) Extras recomendados

```bash
sudo apt install -y bat fd-find tree fastfetch jq ripgrep pipx

mkdir -p ~/.local/bin
command -v fdfind >/dev/null && ln -sf "$(command -v fdfind)" ~/.local/bin/fd
command -v batcat >/dev/null && ln -sf "$(command -v batcat)" ~/.local/bin/bat
```

> 🔴 **`neofetch` não existe mais.** Foi removido do Ubuntu a partir do 25.04 (upstream abandonado). O 26.04 traz **`fastfetch 2.57.1`**, que é drop-in para o uso comum.
>
> No Debian/Ubuntu os binários do `bat` e do `fd` se chamam `batcat` e `fdfind` (conflito de nomes) — daí os symlinks. Os guards com `command -v` evitam criar link quebrado.

Garanta que `~/.local/bin` está no PATH (já incluído na [configuração do zsh](#zshrc-para-ubuntu-nativo)):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

> **Python:** o Ubuntu 24.04+ aplica a PEP 668 — `pip install` fora de um venv falha com `externally-managed-environment`. Use `pipx install <ferramenta>` para CLIs e `python3 -m venv .venv` para projetos. Nunca use `--break-system-packages`.

## 13) GitHub CLI e chave SSH

O repositório do `gh` é *flat* (`stable main`), então **não depende da suite** — o mesmo comando do guia WSL funciona:

```bash
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update && sudo apt install gh -y
```

Configuração do Git:

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@exemplo.com"
git config --global init.defaultBranch main
```

Chave SSH:

```bash
ssh-keygen -t ed25519 -C "seu-email@exemplo.com"
ssh-add ~/.ssh/id_ed25519

gh auth login                                    # escolha SSH quando perguntado
gh ssh-key add ~/.ssh/id_ed25519.pub --title "Ubuntu Desktop"

ssh -T git@github.com
```

> **Diferença em relação ao WSL:** no Ubuntu Desktop o **GNOME Keyring já fornece um `ssh-agent`** e exporta `SSH_AUTH_SOCK` na sua sessão gráfica — por isso o `eval "$(ssh-agent -s)"` do guia WSL normalmente é desnecessário aqui. O bloco no `.zshrc` abaixo tem guard `-z "$SSH_AUTH_SOCK"`, então ele simplesmente não dispara quando o keyring já cuidou disso (e continua funcionando se você entrar via TTY puro).
>
> Para copiar a chave pública no Wayland: `wl-copy < ~/.ssh/id_ed25519.pub` (era `clip.exe` no WSL).

<div align="right"><a href="#top">⬆️ Voltar ao topo</a></div>

## 14) Apps de desenvolvimento (nativos)

Aqui morrem todos os aliases `/mnt/c/...` do guia WSL: os apps rodam **no Linux**.

**VS Code** — repositório oficial da Microsoft (evita o snap, que tem problemas com fontes e integração):

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
  | sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
sudo chmod a+r /etc/apt/keyrings/microsoft.gpg

echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
  | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

sudo apt update && sudo apt install -y code
```

> Esse é o **único** repositório da Microsoft que você deve adicionar. Ele publica só o VS Code e **não** conflita com o .NET do passo 10 (diferente do `packages-microsoft-prod`, que republica os pacotes `dotnet-*`).
>
> Com o `code` nativo no PATH, o script `src/vscode-extensions-install.sh` deste repositório passa a funcionar.

**JetBrains (IntelliJ, WebStorm, Rider)** — via Toolbox App, que gerencia versões e cria os launchers:

```bash
cd /tmp
curl -fsSL "https://data.services.jetbrains.com/products/download?code=TBA&platform=linux" -o jetbrains-toolbox.tar.gz
tar -xzf jetbrains-toolbox.tar.gz
./jetbrains-toolbox-*/jetbrains-toolbox    # abre a GUI; instale as IDEs por lá
```

O Toolbox cria os *shell scripts* em `~/.local/share/JetBrains/Toolbox/scripts` — que já está coberto pelo `PATH` do `.zshrc` abaixo. Depois disso, `idea .` e `webstorm .` funcionam direto, sem alias e sem `wslpath`.

**Cursor** — distribuído como AppImage:

```bash
sudo apt install -y libfuse2t64
mkdir -p ~/.local/bin ~/Applications
# Baixe o AppImage em https://cursor.com/downloads e salve em ~/Applications/
chmod +x ~/Applications/Cursor-*.AppImage
ln -sf ~/Applications/Cursor-*.AppImage ~/.local/bin/cursor
```

## Validação da instalação

Rode **depois** de fazer logout/login (ou `exec zsh`) — antes disso o PATH ainda não tem as ferramentas.

```bash
echo "🔍 Validando instalações..."
echo "==========================================="
check() { command -v "$1" >/dev/null 2>&1 && echo "✅ $1: $(eval "$2" 2>&1 | head -n 1)" || echo "❌ $1 não encontrado"; }

check zsh       'zsh --version'
check git       'git --version'
check fnm       'fnm --version'
check node      'node -v'
check pnpm      'pnpm -v'
check java      'java -version 2>&1'
check mvn       'mvn -v'
check gradle    'gradle -v 2>&1 | grep Gradle'
check php       'php -v'
check composer  'composer --version'
check dotnet    'dotnet --version'
check docker    'docker --version'
check gh        'gh --version'
check bat       'bat --version'
check fd        'fd --version'
check fastfetch 'fastfetch --version'
check code      'code --version'
echo "-------------------------------------------"
docker compose version >/dev/null 2>&1 && echo "✅ docker compose: $(docker compose version)" || echo "❌ docker compose não encontrado"
systemctl is-active docker >/dev/null 2>&1 && echo "✅ daemon docker ativo" || echo "❌ daemon docker inativo"
id -nG | grep -qw docker && echo "✅ usuário no grupo docker" || echo "⚠️  faça logout/login para o grupo docker valer"
[ "$(getent passwd "$USER" | cut -d: -f7)" = "$(command -v zsh)" ] && echo "✅ zsh é o shell de login" || echo "⚠️  shell de login ainda não é o zsh (rode chsh e faça logout)"
fc-list | grep -qi "MesloLGS" && echo "✅ Nerd Font instalada" || echo "❌ Nerd Font não encontrada (passo 1.1)"
echo "==========================================="
```

## Troubleshooting

### 🎨 Tema sem ícones / quadradinhos no prompt

- **Motivo:** a Nerd Font não está instalada **no Linux**, ou o perfil do terminal não está usando ela. No WSL a fonte ficava no Windows; aqui não.
- **Solução:** `fc-list | grep -i MesloLGS`. Se não retornar nada, refaça o [passo 1.1](#11-instalar-uma-nerd-font). Se retornar, o problema é o perfil do Ptyxis ([passo 1.2](#12-configurar-o-terminal)).
- **Atenção:** `fonts-jetbrains-mono` do apt **não** serve — não tem os glifos do Nerd Fonts.

### 🐚 O terminal continua abrindo em bash

- **Motivo:** o `chsh` altera o shell de **login**, e a sessão gráfica só relê isso no próximo login.
- **Solução:** `getent passwd "$USER" | cut -d: -f7` para confirmar que já é `/usr/bin/zsh`, depois **logout/login**. Não existe `wsl --shutdown` aqui.

### 🐘 `Unable to locate package php8.4-cli` / PPA sem `Release file`

- **Motivo:** você usou o passo do guia WSL. O `ppa:ondrej/php` não publica para `resolute` e a série 8.4 não está no 26.04.
- **Solução:** use o **PHP 8.5 nativo** do [passo 9](#9-php-85). Se já adicionou o PPA:
  ```bash
  sudo add-apt-repository --remove ppa:ondrej/php -y
  sudo rm -f /etc/apt/sources.list.d/ondrej-*.list /etc/apt/sources.list.d/ondrej-*.sources
  sudo apt update
  ```

### 🔴 `Unable to locate package dotnet-sdk-10.0`

- **Motivo:** repositório `packages-microsoft-prod` convivendo com o feed nativo do Ubuntu.
- **Solução:**
  ```bash
  sudo apt remove -y packages-microsoft-prod
  sudo rm -f /etc/apt/sources.list.d/microsoft-prod.list
  sudo apt update
  ```
  O repo do **VS Code** ([passo 14](#14-apps-de-desenvolvimento-nativos)) é outro e pode ficar — ele não republica pacotes `dotnet-*`.

### 🐳 Docker diz "Cannot connect to the Docker daemon"

- **Solução:**
  1. `systemctl status docker` — se estiver parado, `sudo systemctl enable --now docker`.
  2. `id -nG | grep docker` — se não aparecer, faça **logout/login** (o `usermod -aG` não afeta sessões já abertas).
  3. Se você migrou de outra máquina com Docker Desktop, rode `docker context use default`.

### 🦊 Removi o snapd e o Firefox sumiu

- **Motivo:** no Ubuntu Desktop o Firefox, o App Center e o firmware-updater são snaps.
- **Solução:** instale o Firefox `.deb` da Mozilla — veja o [Anexo A](#anexo-a--remover-o-snap-só-se-você-realmente-quiser). Para voltar atrás por completo: `sudo apt install --reinstall snapd && sudo snap install firefox`.

### 🦀 Um script quebra com "unexpected argument" em `ls`, `head`, `wc`…

- **Motivo:** o 26.04 usa `rust-coreutils` (uutils) por padrão; alguma flag do GNU não foi implementada.
- **Solução:** `sudo apt install -y coreutils` para restaurar o GNU como padrão. Veja o [passo 2.2](#22-novidades-do-2604-que-afetam-scripts).

### ⚠️ `command not found: pyenv` (ou `dotnet`, `bun`) a cada terminal

- **Motivo:** o `~/.zshrc` chama `eval "$(pyenv init -)"` sem checar se a ferramenta existe.
- **Solução:** todo bloco opcional precisa de guard:
  ```bash
  command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init - zsh)"
  ```
- **Bônus:** qualquer saída no início do `.zshrc` dispara o aviso do *instant prompt* do Powerlevel10k.

### 🎨 Realce de sintaxe não funciona

- **Motivo:** ordem dos plugins. O `zsh-syntax-highlighting` precisa ser o **último** da lista.
- **Solução:** revise o [passo 5](#5-plugins-úteis-para-zsh).

### 🟢 `fnm` não troca a versão do Node automaticamente

- **Solução:** `eval "$(fnm env --use-on-cd --shell zsh)"` no `~/.zshrc` — a flag `--use-on-cd` é obrigatória.

### 🐍 `error: externally-managed-environment` ao usar pip

- **Motivo:** PEP 668, ativa no Ubuntu desde o 24.04.
- **Solução:** `pipx install <cli>` para ferramentas globais, `python3 -m venv .venv` para projetos.

<div align="right"><a href="#top">⬆️ Voltar ao topo</a></div>

## ~/.zshrc para Ubuntu nativo

> Versão adaptada da configuração do guia WSL. **Mudanças:** removido o `export TERM`, removidos os aliases `/mnt/c/...`, adicionado o PATH do JetBrains Toolbox e aliases de clipboard Wayland. Todos os blocos opcionais têm guard, então pode copiar inteiro. Ajuste os pontos marcados com **AJUSTE**.

```bash
# ================================
# ~/.zshrc - Full Stack Dev (Ubuntu 26.04 nativo)
# ================================

# ------------------------
# Powerlevel10k instant prompt (precisa ser o PRIMEIRO bloco do arquivo)
# ------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
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
  zsh-syntax-highlighting   # SEMPRE o último: ele envolve os widgets já carregados
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7f7f7f'

# ------------------------
# Core Settings
# ------------------------
# NÃO force TERM aqui. Ptyxis/kitty/wezterm anunciam um TERM mais capaz
# (xterm-256color, xterm-kitty...) e sobrescrever isso perde recursos.
DISABLE_AUTO_TITLE=true
ENABLE_CORRECTION="true"

# PATH do usuário: ~/.local/bin (bat, fd, cursor) e ~/bin (scripts deste repositório)
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# JetBrains Toolbox (idea, webstorm, rider... instalados nativamente)
[[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]] \
  && export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

# ------------------------
# Version Managers
# ------------------------

# SDKMAN (Java / Maven / Gradle)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

if [[ -d "$SDKMAN_DIR/candidates/java/current" ]]; then
  export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# FNM (Node.js) — --use-on-cd faz o auto-switch por .nvmrc / .node-version
FNM_PATH="$HOME/.local/share/fnm"
if [[ -d "$FNM_PATH" ]]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Bun (opcional)
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && export PATH="$BUN_INSTALL/bin:$PATH"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# Pyenv (opcional — só carrega se estiver instalado)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
  command -v pyenv-virtualenv-init >/dev/null 2>&1 && eval "$(pyenv virtualenv-init -)"
fi

# ------------------------
# .NET (pacote do Ubuntu — o SDK fica em /usr/lib/dotnet, sem DOTNET_ROOT)
# ------------------------
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export PATH="$PATH:$HOME/.dotnet/tools"

# ------------------------
# Autojump
# ------------------------
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh
# Se preferir zoxide, comente a linha acima, remova "autojump" dos plugins e use:
# command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd j)"

# ------------------------
# SSH agent
# ------------------------
# No Ubuntu Desktop o GNOME Keyring já exporta SSH_AUTH_SOCK na sessão gráfica,
# então este bloco só dispara em TTY puro / sessão sem keyring.
if [[ -z "$SSH_AUTH_SOCK" && -f "$HOME/.ssh/id_ed25519" ]]; then
  eval "$(ssh-agent -s)" >/dev/null
  ssh-add -q "$HOME/.ssh/id_ed25519" 2>/dev/null
fi

# ------------------------
# Clipboard (Wayland é o padrão no Ubuntu 26.04)
# ------------------------
if command -v wl-copy >/dev/null 2>&1; then
  alias pbcopy='wl-copy'
  alias pbpaste='wl-paste'
elif command -v xclip >/dev/null 2>&1; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi
# Uso: cat ~/.ssh/id_ed25519.pub | pbcopy

# ------------------------
# Custom Script Aliases (scripts copiados para ~/bin)
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

# ──────────────────────
# Useful Aliases
# ──────────────────────

# System
alias update='sudo apt update && sudo apt upgrade -y'
alias cleanup='sudo apt autoremove -y && sudo apt autoclean'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Productivity
alias c='clear'
alias h='history'
alias ll='ls -lah'
alias ff='fastfetch'

# Container management
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dstart='docker start'
alias dstop='docker stop'
alias drm='docker rm'
alias drmf='docker rm -f'

# Docker Compose
alias dc='docker compose'
alias dcup='docker compose up -d'
alias dcdown='docker compose down'
alias dclogs='docker compose logs -f'
alias dcps='docker compose ps'
alias dcrestart='docker compose restart'

# ------------------------
# Powerlevel10k Config (mantenha no fim do arquivo)
# ------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

## Scripts do repositório: o que quebra fora do WSL

```bash
mkdir -p ~/bin
cp src/*.sh ~/bin/
chmod +x ~/bin/*.sh
```

| Script | Status no Ubuntu nativo | Observação |
|---|---|---|
| `check-version.sh` | ✅ Funciona | — |
| `docker-login.sh` | ✅ Funciona | — |
| `fastify-postgresql-script.sh` | ✅ Funciona | Depende de Docker + Node, já instalados |
| `git-push-origin.sh` | ✅ Funciona | — |
| `git-push-faculdade.sh` | ✅ Funciona | — |
| `next-shadcn-biome.sh` | ✅ Funciona | — |
| `next-shadcn-prettierrc.sh` | ✅ Funciona | — |
| `react-router-v7.sh` | ✅ Funciona | — |
| `restart-docker.sh` | ✅ Funciona | — |
| `vscode-extensions-install.sh` | ✅ Passa a funcionar | Precisa do `code` nativo ([passo 14](#14-apps-de-desenvolvimento-nativos)); no WSL vinha do Windows |
| `idea.sh` | 🔴 **Quebra** | Usa `wslpath` e `cmd.exe`. Veja o substituto abaixo |
| `install.sh` | ⚠️ Roda, mas orienta errado | `require_wsl_ubuntu` avisa; as instruções finais falam em `wsl --shutdown` e "Docker Desktop com integração WSL". Ignore essas mensagens — o resto (zsh, p10k, plugins, fnm, SDKMAN, grupo docker, symlinks) é válido |
| `dev-machine-setup.sh` | 🔴 **Não execute** | Faz `echo ... > /etc/wsl.conf` (sem efeito, e sobrescreve com `>`), instala `neofetch` (inexistente no 26.04) e grava aliases `/mnt/c/...`. Use este guia no lugar dele |

**Substituto do `idea.sh`:** com o JetBrains Toolbox instalado, o comando `idea` já existe no PATH. O script deixa de ser necessário — mas se quiser manter o nome:

```bash
#!/usr/bin/env bash
# ~/bin/idea.sh — abre o IntelliJ nativo no diretório informado (ou no atual)
exec idea "${1:-$PWD}"
```

<div align="right"><a href="#top">⬆️ Voltar ao topo</a></div>

## Anexo A – Remover o snap (só se você realmente quiser)

> **Recomendação: não remova.** No 26.04 o snap carrega Firefox, App Center, firmware-updater e o Desktop Security Center. O ganho de performance em desktop moderno é pequeno; o risco de ficar sem navegador é real. Este anexo existe porque o guia WSL sugere a remoção — lá era seguro, aqui não é.

Se decidir seguir, **instale o Firefox `.deb` primeiro**:

```bash
# 1) Repositório oficial da Mozilla (.deb, não snap)
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://packages.mozilla.org/apt/repo-signing-key.gpg \
  | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
  | sudo tee /etc/apt/sources.list.d/mozilla.list > /dev/null

# 2) Prioriza o .deb da Mozilla sobre o pacote de transição do Ubuntu (que puxa o snap)
printf 'Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n' \
  | sudo tee /etc/apt/preferences.d/mozilla > /dev/null

sudo apt update && sudo apt install -y firefox

# 3) Só agora remova os snaps — confira o que existe antes
snap list
sudo snap remove --purge firefox 2>/dev/null || true
# remova os demais snaps um a um; deixe as bases (core*, gnome-*, gtk-*) por último

# 4) E por fim o snapd
sudo systemctl disable --now snapd.service snapd.socket snapd.seeded.service 2>/dev/null || true
sudo apt purge -y snapd
sudo rm -rf /snap /var/snap /var/lib/snapd /var/cache/snapd ~/snap

# 5) Impede que o apt reinstale o snapd por dependência
printf 'Package: snapd\nPin: release a=*\nPin-Priority: -10\n' \
  | sudo tee /etc/apt/preferences.d/nosnap.pref > /dev/null
```

Como substituto do App Center, instale o Flatpak + Flathub:

```bash
sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo reboot
```

Para reverter tudo: `sudo rm /etc/apt/preferences.d/nosnap.pref && sudo apt install snapd && sudo snap install firefox`.

## Anexo B – Diferenças 24.04 vs 26.04

Se você acabar instalando o **24.04 LTS (Noble)** em vez do 26.04, só três pontos deste guia mudam:

| Item | Ubuntu 24.04 (`noble`) | Ubuntu 26.04 (`resolute`) |
|---|---|---|
| **PHP** | `ppa:ondrej/php` **funciona**; use `PHP_V=8.4` (como no guia WSL) | PPA **não publica** para `resolute`; use o **PHP 8.5 nativo**, sem PPA |
| **fetch** | `neofetch 7.1.0` disponível; `fastfetch` **não** está no repositório | `neofetch` **removido**; use `fastfetch 2.57.1` |
| **coreutils / sudo** | GNU coreutils e sudo tradicionais | `rust-coreutils` (uutils) e `sudo-rs` por padrão |
| **Terminal padrão** | GNOME Terminal | **Ptyxis** |
| **.NET** | `dotnet-sdk-10.0` = `10.0.111-0ubuntu1~24.04.1` | `dotnet-sdk-10.0` = `10.0.111-0ubuntu1~26.04.1` |

Todo o resto — Docker, `gh`, fnm, SDKMAN, zsh/p10k/plugins, `fzf`, `autojump`, `bat`, `fd-find`, `zoxide` — é idêntico nas duas releases.

<div align="center">
  <b>Construído para hardware real, sem camada de virtualização.</b><br>
  <a href="#top">⬆️ Voltar ao topo</a>
</div>
