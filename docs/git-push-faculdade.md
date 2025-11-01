# git-push-faculdade.sh

## Descrição

Script automatizado para realizar commit e push para o remote `faculdade` no Git, facilitando o fluxo de trabalho com múltiplos remotes.

## Funcionalidade

### 1. Validação

- Verifica se o diretório atual é um repositório Git
- Garante que existe um diretório `.git`

### 2. Status do Repositório

- Exibe o status atual com `git status`
- Mostra arquivos modificados, adicionados ou removidos

### 3. Criação do Commit

- Solicita mensagem de commit interativamente
- Valida que a mensagem não está vazia
- Adiciona todos os arquivos com `git add .`
- Cria o commit com a mensagem fornecida

### 4. Push Automático

- Detecta a branch atual automaticamente
- Realiza push para o remote `faculdade` na branch detectada

## Como Usar

### Pré-requisito: Configurar Remote

Antes de usar o script, configure o remote `faculdade`:

```bash
# Adicionar remote faculdade
git remote add faculdade https://github.com/usuario/repositorio-faculdade.git

# Ou com SSH
git remote add faculdade git@github.com:usuario/repositorio-faculdade.git

# Verificar remotes
git remote -v
```

### Executar o script

```bash
./src/git-push-faculdade.sh
```

ou

```bash
bash src/git-push-faculdade.sh
```

## Fluxo Interativo

```
📦 Status do repositório:
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  modified:   README.md

✏️  Digite a mensagem do commit: feat: adiciona documentação
➕ Adicionando arquivos...
📝 Criando commit...
🚀 Enviando para a branch 'main'...
✅ Push realizado com sucesso!
```

## Mensagens de Erro

### Não está em um repositório Git

```
❌ Você não está em um repositório Git!
```

### Mensagem de commit vazia

```
⚠️  A mensagem do commit não pode estar vazia!
```

### Remote não configurado

Se o remote `faculdade` não existir:

```
fatal: 'faculdade' does not appear to be a git repository
```

## Casos de Uso

### 1. Múltiplos Remotes (Faculdade + Pessoal)

```bash
# Remote pessoal (origin)
git remote add origin https://github.com/seu-usuario/projeto.git

# Remote da faculdade
git remote add faculdade https://github.com/faculdade/projeto.git

# Usar o script para push na faculdade
./src/git-push-faculdade.sh

# Ou push manual no origin
git push origin main
```

### 2. Branches Diferentes

O script detecta automaticamente a branch:

```bash
# Em main
git checkout main
./src/git-push-faculdade.sh  # Push para faculdade/main

# Em develop
git checkout develop
./src/git-push-faculdade.sh  # Push para faculdade/develop
```

### 3. Fork e Upstream

```bash
# Origin = seu fork
git remote add origin https://github.com/seu-usuario/projeto.git

# Faculdade = repositório original
git remote add faculdade https://github.com/faculdade/projeto-original.git

# Push para faculdade com o script
./src/git-push-faculdade.sh
```

## Boas Práticas de Mensagens de Commit

### Conventional Commits

```
feat: adiciona novo recurso
fix: corrige bug na API
docs: atualiza README
style: formata código
refactor: refatora função X
test: adiciona testes unitários
chore: atualiza dependências
```

### Mensagens Descritivas

```
✅ Bom: feat: adiciona autenticação JWT na API
❌ Ruim: update

✅ Bom: fix: corrige validação de email no formulário
❌ Ruim: bug fix

✅ Bom: docs: adiciona instruções de instalação
❌ Ruim: doc
```

## Requisitos

- Git instalado e configurado
- Repositório Git inicializado
- Remote `faculdade` configurado
- Permissões de push no repositório remoto

## Script Relacionado

- **git-push-origin.sh**: Versão idêntica para push no remote `origin`

## Diferenças entre os Scripts

| Script                | Remote    | Uso Típico                    |
| --------------------- | --------- | ----------------------------- |
| git-push-faculdade.sh | faculdade | Repositório da instituição    |
| git-push-origin.sh    | origin    | Repositório pessoal/principal |

## Personalização

Para mudar o remote de destino, edite a linha:

```bash
git push faculdade "$branch"
```

Para:

```bash
git push outro-remote "$branch"
```

## Observações

- O script usa `git add .` - todos os arquivos são adicionados
- A branch é detectada automaticamente
- Útil para fluxos de trabalho com múltiplos remotes
- Emojis facilitam a visualização do progresso
