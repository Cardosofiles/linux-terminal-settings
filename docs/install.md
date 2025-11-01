# install.sh

## Descrição

Script completo e idempotente para configurar um ambiente de desenvolvimento moderno no WSL Ubuntu, incluindo Zsh, Oh My Zsh, Powerlevel10k, ferramentas Node.js, Java, Docker e muito mais.

## Funcionalidade

Este script automatiza a instalação e configuração de todo um ambiente de desenvolvimento profissional:

### 1. Sistema Base (APT)

- Atualização do sistema
- Ferramentas essenciais:
  - `curl`, `git`, `unzip`, `build-essential`
  - `zip`, `htop`, `wget`
  - `ca-certificates`, `gnupg`, `lsb-release`
  - `fzf` (fuzzy finder)
  - `bat` (cat melhorado)
  - `fd-find` (find melhorado)
  - `tree` (visualização de árvore)
  - `neofetch` (info do sistema)
  - `zsh` (shell avançado)

### 2. Zsh e Oh My Zsh

- Instala Zsh
- Define Zsh como shell padrão
- Instala Oh My Zsh (gerenciador de configurações)
- Modo não-interativo (sem prompts)

### 3. Tema Powerlevel10k

- Clone do repositório Powerlevel10k
- Configuração automática no `.zshrc`
- Tema moderno com informações contextuais

### 4. Plugins Zsh

- **zsh-autosuggestions**: Sugestões baseadas no histórico
- **zsh-syntax-highlighting**: Destaque de sintaxe em tempo real
- **git**: Aliases e funcionalidades Git

### 5. Node.js via FNM (Fast Node Manager)

- Instalação do FNM
- Instalação do Node.js LTS
- Configuração no `.zshrc`
- Ativação automática por diretório
- **pnpm**: Instalado via Corepack

### 6. Java via SDKMAN

- Instalação do SDKMAN
- **Java 21 Temurin** (Eclipse Adoptium)
- **Maven** (gerenciador de build)
- **Gradle** (gerenciador de build)

### 7. Docker

- Adiciona usuário ao grupo `docker`
- Permite uso sem `sudo`
- Requer reinício do WSL para aplicar

### 8. Utilitários Extras

- Cria `~/.local/bin` para binários locais
- Symlinks para `fd` e `bat` (nomes originais)
- Adiciona ao PATH

## Como Usar

### Executar o script

```bash
./src/install.sh
```

ou

```bash
bash src/install.sh
```

### Modo Verbose (Debug)

```bash
bash -x src/install.sh
```

## Fluxo de Instalação

O script executa as seguintes funções em ordem:

1. ✅ `require_wsl_ubuntu` - Verifica ambiente WSL
2. ✅ `setup_apt` - Atualiza sistema e instala pacotes
3. ✅ `setup_zsh_ohmyzsh` - Instala Zsh e Oh My Zsh
4. ✅ `setup_powerlevel10k` - Configura tema
5. ✅ `setup_zsh_plugins` - Instala plugins
6. ✅ `setup_fnm_node_pnpm` - Instala Node.js e pnpm
7. ✅ `setup_sdkman_java` - Instala Java, Maven, Gradle
8. ✅ `setup_docker_group` - Configura grupo Docker
9. ✅ `setup_extras` - Ajustes finais
10. ✅ `post_instructions` - Instruções pós-instalação

## Pós-Instalação

Após executar o script:

### 1. Reiniciar WSL

```powershell
# No PowerShell (Windows)
wsl --shutdown
```

Depois abra novamente o WSL.

### 2. Configurar Powerlevel10k

Na primeira execução do Zsh:

- Assistente de configuração será iniciado
- Escolha seu estilo preferido
- Configure ícones, cores, segmentos

### 3. Instalar Nerd Font

Para visualizar ícones corretamente:

**No Windows Terminal:**

1. Baixe uma Nerd Font: https://www.nerdfonts.com/
2. Recomendado: **MesloLGS NF**
3. Instale a fonte no Windows
4. Configure no Windows Terminal:
   ```json
   {
     "profiles": {
       "defaults": {
         "font": {
           "face": "MesloLGS NF"
         }
       }
     }
   }
   ```

**No VS Code:**

```json
{
  "terminal.integrated.fontFamily": "MesloLGS NF"
}
```

### 4. Verificar Instalação

```bash
# Versões instaladas
zsh --version
echo $SHELL

# Node.js e gerenciadores
node -v
npm -v
pnpm -v

# Java e ferramentas
java -version
mvn -v
gradle -v

# Docker (requer Docker Desktop + integração WSL)
docker run hello-world
```

## Estrutura de Arquivos Criados/Modificados

```
~/.oh-my-zsh/                          # Oh My Zsh
~/.oh-my-zsh/custom/themes/powerlevel10k/  # Tema
~/.oh-my-zsh/custom/plugins/           # Plugins
~/.zshrc                               # Configuração Zsh
~/.fnm/                                # Fast Node Manager
~/.sdkman/                             # SDKMAN
~/.local/bin/                          # Binários locais
~/.p10k.zsh                            # Config Powerlevel10k (após wizard)
```

## Características do Script

### Idempotência

O script pode ser executado múltiplas vezes sem problemas:

- Verifica se ferramentas já estão instaladas
- Não reinstala se já existir
- Atualiza configurações preservando as existentes

### Segurança

- `set -euo pipefail`: Falha em erros
- Validações antes de executar
- Não sobrescreve configurações críticas

### Funções Auxiliares

```bash
ensure_cmd()           # Verifica se comando existe
append_if_missing()    # Adiciona linha se não existir
replace_or_append()    # Substitui ou adiciona linha
log()                  # Mensagem informativa
ok()                   # Mensagem de sucesso
warn()                 # Mensagem de aviso
err()                  # Mensagem de erro
```

## Plugins Zsh Incluídos

### git

- Aliases: `gst`, `gco`, `gaa`, `gcmsg`, etc.
- Funcionalidades Git no prompt

### zsh-autosuggestions

- Sugestões baseadas no histórico
- Aceitar: `→` (seta direita)
- Cor cinza claro

### zsh-syntax-highlighting

- Destaque de comandos válidos (verde)
- Destaque de comandos inválidos (vermelho)
- Destaque de strings, paths, etc.

## Versões Instaladas

| Ferramenta | Versão              |
| ---------- | ------------------- |
| Node.js    | LTS (latest)        |
| pnpm       | Latest via Corepack |
| Java       | 21.0.5 Temurin      |
| Maven      | Latest via SDKMAN   |
| Gradle     | Latest via SDKMAN   |
| Zsh        | Repositório APT     |

## Requisitos Prévios

### Sistema

- Windows 10/11 com WSL2
- Distribuição Ubuntu (20.04, 22.04 ou 24.04)
- Conexão com internet

### Docker

- Docker Desktop instalado no Windows
- Integração WSL2 ativada em:
  - Settings → Resources → WSL Integration
  - Habilitar para sua distribuição Ubuntu

## Troubleshooting

### Erro: Shell não mudou

```bash
# Mudar manualmente
chsh -s $(which zsh)

# Reiniciar terminal
```

### Erro: Grupo Docker não aplicado

```bash
# Verificar grupo
groups

# Se não aparecer 'docker', reinicie WSL
# No PowerShell:
wsl --shutdown
```

### Erro: FNM não encontrado

```bash
# Recarregar .zshrc
source ~/.zshrc

# Ou reiniciar terminal
```

### Erro: SDKMAN não encontrado

```bash
# Carregar SDKMAN
source ~/.sdkman/bin/sdkman-init.sh

# Verificar instalação
sdk version
```

### Powerlevel10k não aparece

1. Verifique se instalou Nerd Font
2. Configure a fonte no terminal
3. Execute: `p10k configure`

## Aliases e Comandos Úteis

### Após Instalação

```bash
# Recarregar configuração Zsh
source ~/.zshrc

# Reconfigurar Powerlevel10k
p10k configure

# Atualizar Oh My Zsh
omz update

# Listar plugins
omz plugin list

# FNM: listar versões Node
fnm list

# FNM: instalar versão específica
fnm install 18
fnm use 18

# SDKMAN: listar candidatos
sdk list

# SDKMAN: instalar Java 17
sdk install java 17.0.9-tem
```

## Personalização

### Adicionar Mais Plugins Zsh

Edite `~/.zshrc`:

```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker                    # Adicione mais aqui
  npm
  yarn
)
```

### Adicionar Aliases

No final do `~/.zshrc`:

```bash
# Aliases personalizados
alias ll='ls -lah'
alias gs='git status'
alias dc='docker-compose'
alias pn='pnpm'
```

## Observações Importantes

1. ⚠️ Requer reinício do WSL após instalação
2. ⚠️ Docker precisa do Docker Desktop no Windows
3. ⚠️ Nerd Font necessária para ícones do Powerlevel10k
4. ✅ Script é idempotente (pode reexecutar)
5. ✅ Não sobrescreve configurações existentes
6. ✅ Compatível com Ubuntu 20.04, 22.04 e 24.04
