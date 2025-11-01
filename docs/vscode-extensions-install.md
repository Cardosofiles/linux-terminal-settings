# vscode-extensions-install.sh

## Descrição

Script simples para instalar extensões do VS Code a partir de um arquivo de texto contendo a lista de extensões.

## Funcionalidade

### 1. Leitura de Arquivo

- Lê o arquivo `vscode-extensions.txt` linha por linha
- Cada linha deve conter o ID de uma extensão

### 2. Instalação Automática

- Para cada extensão encontrada:
  - Executa comando `code --install-extension`
  - Instala a extensão no VS Code

### 3. Feedback

- Exibe mensagem de início
- Exibe mensagem de conclusão

## Estrutura de Arquivos

### vscode-extensions.txt

Crie um arquivo `vscode-extensions.txt` no mesmo diretório do script:

```
dbaeumer.vscode-eslint
esbenp.prettier-vscode
bradlc.vscode-tailwindcss
ms-python.python
ms-vscode.vscode-typescript-next
eamodio.gitlens
usernamehw.errorlens
```

Cada linha = uma extensão.

## Como Usar

### 1. Criar Lista de Extensões

#### Método 1: Exportar Extensões Instaladas

```bash
# Listar extensões instaladas
code --list-extensions

# Salvar em arquivo
code --list-extensions > vscode-extensions.txt
```

#### Método 2: Criar Manualmente

```bash
# Criar arquivo
touch vscode-extensions.txt

# Editar e adicionar IDs
vim vscode-extensions.txt
```

### 2. Executar o Script

```bash
./src/vscode-extensions-install.sh
```

ou

```bash
bash src/vscode-extensions-install.sh
```

## Saída Esperada

```
Instalando extensões do VSCode...
Installing extensions...
Extension 'dbaeumer.vscode-eslint' is already installed.
Installing extensions...
Extension 'esbenp.prettier-vscode' v10.1.0 was successfully installed.
Installing extensions...
Extension 'bradlc.vscode-tailwindcss' v0.10.5 was successfully installed.
...
Tudo instalado com sucesso!
```

## Extensões Recomendadas

### Desenvolvimento Web

#### JavaScript/TypeScript

```
dbaeumer.vscode-eslint
esbenp.prettier-vscode
ms-vscode.vscode-typescript-next
bradlc.vscode-tailwindcss
formulahendry.auto-rename-tag
formulahendry.auto-close-tag
```

#### React

```
dsznajder.es7-react-js-snippets
burkeholland.simple-react-snippets
```

#### Vue

```
vue.volar
vue.vscode-typescript-vue-plugin
```

### Desenvolvimento Backend

#### Python

```
ms-python.python
ms-python.vscode-pylance
ms-python.black-formatter
```

#### Java

```
vscjava.vscode-java-pack
vscjava.vscode-spring-boot-dashboard
```

#### Node.js

```
christian-kohler.npm-intellisense
eg2.vscode-npm-script
```

### Ferramentas de Produtividade

#### Git

```
eamodio.gitlens
mhutchie.git-graph
donjayamanne.githistory
```

#### Utilitários

```
usernamehw.errorlens
wayou.vscode-todo-highlight
gruntfuggly.todo-tree
PKief.material-icon-theme
```

#### Docker

```
ms-azuretools.vscode-docker
ms-vscode-remote.remote-containers
```

### Code Quality

```
streetsidesoftware.code-spell-checker
oderwat.indent-rainbow
naumovs.color-highlight
```

### Temas Populares

```
PKief.material-icon-theme
zhuangtongfa.material-theme
GitHub.github-vscode-theme
```

## Criar Perfis de Extensões

### Perfil Frontend

```bash
# frontend-extensions.txt
dbaeumer.vscode-eslint
esbenp.prettier-vscode
bradlc.vscode-tailwindcss
dsznajder.es7-react-js-snippets
eamodio.gitlens
```

### Perfil Backend

```bash
# backend-extensions.txt
ms-python.python
ms-vscode.vscode-typescript-next
ms-azuretools.vscode-docker
redhat.vscode-yaml
```

### Perfil Full Stack

```bash
# Combine ambos
cat frontend-extensions.txt backend-extensions.txt > fullstack-extensions.txt
```

## Encontrar IDs de Extensões

### Método 1: Marketplace

1. Acesse https://marketplace.visualstudio.com/vscode
2. Procure a extensão
3. O ID está na URL: `publisher.extension-name`

### Método 2: VS Code

1. Abra Extensions (Ctrl+Shift+X)
2. Clique na extensão
3. Clique no ⚙️ → "Copy Extension ID"

### Método 3: Terminal

```bash
# Listar todas instaladas
code --list-extensions

# Buscar específica
code --list-extensions | grep eslint
```

## Desinstalar Extensões

### Script de Desinstalação

```bash
#!/bin/bash
# vscode-extensions-uninstall.sh

while read extension; do
  code --uninstall-extension "$extension"
done < vscode-extensions.txt

echo "Tudo desinstalado!"
```

## Sincronizar Entre Máquinas

### Exportar

```bash
# Na máquina antiga
code --list-extensions > vscode-extensions.txt
```

### Transferir

```bash
# Copiar arquivo para nova máquina
scp vscode-extensions.txt usuario@novamaquina:~
```

### Importar

```bash
# Na máquina nova
./vscode-extensions-install.sh
```

## Versões Específicas

Para instalar versão específica:

```bash
code --install-extension publisher.extension@1.2.3
```

Edite o script para suportar versões:

```bash
#!/bin/bash
while read extension; do
  if [[ $extension == *"@"* ]]; then
    code --install-extension "$extension"
  else
    code --install-extension "$extension"
  fi
done < vscode-extensions.txt
```

## Requisitos

- VS Code instalado
- Comando `code` disponível no PATH
- Arquivo `vscode-extensions.txt` no mesmo diretório

## Configurar Comando `code`

### Linux/WSL

```bash
# Adicionar ao PATH
export PATH="$PATH:/usr/share/code/bin"

# Ou criar symlink
sudo ln -s /usr/share/code/bin/code /usr/local/bin/code
```

### macOS

```bash
# Instalar via VS Code
# Cmd+Shift+P → "Shell Command: Install 'code' command in PATH"
```

### Windows

```bash
# Adicionar ao PATH do sistema
# C:\Users\Usuario\AppData\Local\Programs\Microsoft VS Code\bin
```

## Troubleshooting

### Erro: code: command not found

```bash
# Verificar se VS Code está instalado
which code

# Instalar comando shell
# No VS Code: Cmd/Ctrl+Shift+P → "Install 'code' command"
```

### Erro: arquivo não encontrado

```bash
# Criar arquivo se não existir
touch vscode-extensions.txt

# Verificar localização
ls -la vscode-extensions.txt
```

### Extensão não instala

```bash
# Instalar manualmente para testar
code --install-extension dbaeumer.vscode-eslint

# Ver erros detalhados
code --verbose --install-extension publisher.extension
```

### Permissões negadas

```bash
# Dar permissão de execução
chmod +x vscode-extensions-install.sh
```

## Melhorias do Script

### Adicionar Contador

```bash
#!/bin/bash
echo "Instalando extensões do VSCode..."
count=0
while read extension; do
  code --install-extension "$extension"
  ((count++))
done < vscode-extensions.txt
echo "$count extensões processadas!"
```

### Adicionar Verificação

```bash
#!/bin/bash
if [ ! -f "vscode-extensions.txt" ]; then
  echo "❌ Arquivo vscode-extensions.txt não encontrado!"
  exit 1
fi

while read extension; do
  code --install-extension "$extension"
done < vscode-extensions.txt
echo "✅ Tudo instalado!"
```

### Adicionar Log

```bash
#!/bin/bash
LOG_FILE="install-log.txt"
echo "Instalando extensões do VSCode..."
while read extension; do
  echo "Instalando: $extension" | tee -a "$LOG_FILE"
  code --install-extension "$extension" >> "$LOG_FILE" 2>&1
done < vscode-extensions.txt
echo "Tudo instalado! Log em: $LOG_FILE"
```

## Observações

- ✅ Script simples e direto
- ✅ Útil para configuração de novas máquinas
- ✅ Facilita sincronização de extensões
- ⚠️ Requer comando `code` configurado
- ⚠️ Não verifica se extensão já está instalada (VS Code faz isso)
- 📦 Ideal para times padronizarem ambiente
