# 🚀 Terminal Dev Perfeito no Windows (WSL) com Zsh, Starship, FZF e Nerd Fonts

Este tutorial guia você na personalização do terminal no Windows com WSL (Ubuntu) para ficar igual ao prompt do Warp, incluindo:

- Fonte com ícones (Nerd Font)
- Zsh com autosuggestions e syntax highlighting
- Prompt moderno com Starship
- Terminal interativo com FZF

---

## 🧰 Pré-requisitos

- [Windows Terminal](https://aka.ms/terminal) instalado
- [Ubuntu (WSL)](https://aka.ms/wsl) configurado
- Fonte **MesloLGS NF** ou outra **Nerd Font** instalada no Windows
- Acesso root ao Ubuntu/WSL

---

## 🪛 Passo a Passo

### 1. 🪟 Instale e configure o Windows Terminal

- Baixe pela Microsoft Store: [Windows Terminal](https://aka.ms/terminal)
- Abra o terminal > clique na setinha ↓ > `Configurações`
- Configure o Ubuntu como perfil padrão
- Em "Aparência", altere a fonte para `MesloLGS NF` (ou qualquer outra Nerd Font instalada)

> 💡 Baixe Nerd Fonts em: https://www.nerdfonts.com/font-downloads

---

### 2. 🐚 Instale e configure o Zsh

```bash
sudo apt update && sudo apt install zsh -y
chsh -s $(which zsh)
```

### 3. ⚡ Oh My Zsh + Plugins

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```

```bash
source ~/.zshrc
```

### 4. 🌈 Prompt moderno com Starship

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

### 5. 🔍 Instale o FZF para terminal interativo

- Instalação via apt:

```bash
sudo apt install fzf -y
```

### 6. ✅ Resultado Final

Ao concluir os passos, você terá:

- Um terminal moderno com ícones e cores
- Sugestões e realce de sintaxe no Zsh
- Prompt elegante e funcional com Starship
- FZF para navegação, busca de arquivos e comandos

##
