# git-push-origin.sh

## Descrição

Script automatizado para realizar commit e push para o remote `origin` no Git, simplificando o fluxo de trabalho Git padrão.

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
- Realiza push para o remote `origin` na branch detectada

## Como Usar

### Executar o script

```bash
./src/git-push-origin.sh
```

ou

```bash
bash src/git-push-origin.sh
```

## Fluxo Interativo

```
📦 Status do repositório:
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  modified:   src/index.ts
  new file:   docs/README.md

✏️  Digite a mensagem do commit: feat: implementa autenticação JWT
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

**Solução**: Execute `git init` ou navegue até um diretório Git

### Mensagem de commit vazia

```
⚠️  A mensagem do commit não pode estar vazia!
```

**Solução**: Forneça uma mensagem descritiva

### Remote não configurado

```
fatal: 'origin' does not appear to be a git repository
```

**Solução**: Configure o remote origin:

```bash
git remote add origin https://github.com/usuario/repositorio.git
```

### Push rejeitado

```
error: failed to push some refs to 'origin'
```

**Solução**: Faça pull antes do push:

```bash
git pull origin main --rebase
./src/git-push-origin.sh
```

## Casos de Uso

### 1. Workflow Padrão

```bash
# Fazer alterações nos arquivos
vim src/app.ts

# Executar script
./src/git-push-origin.sh

# Digite a mensagem quando solicitado
# ✏️  Digite a mensagem do commit: fix: corrige validação de input
```

### 2. Múltiplas Branches

O script detecta automaticamente a branch:

```bash
# Branch principal
git checkout main
./src/git-push-origin.sh  # Push para origin/main

# Branch de feature
git checkout feature/nova-funcionalidade
./src/git-push-origin.sh  # Push para origin/feature/nova-funcionalidade

# Branch de hotfix
git checkout hotfix/bug-critico
./src/git-push-origin.sh  # Push para origin/hotfix/bug-critico
```

### 3. Primeiro Push

Para novo repositório:

```bash
# Criar repositório no GitHub primeiro
gh repo create meu-projeto --public

# Configurar remote
git remote add origin https://github.com/usuario/meu-projeto.git

# Usar o script
./src/git-push-origin.sh
```

## Convenções de Mensagens de Commit

### Conventional Commits

```
feat: adiciona novo recurso
fix: corrige bug
docs: atualiza documentação
style: formatação de código
refactor: refatora código existente
test: adiciona ou modifica testes
chore: tarefas de manutenção
perf: melhora performance
ci: mudanças em CI/CD
build: mudanças no build
```

### Exemplos Práticos

```
✅ feat: adiciona endpoint de login com JWT
✅ fix: corrige vazamento de memória no cache
✅ docs: adiciona documentação da API REST
✅ refactor: simplifica lógica de validação
✅ test: adiciona testes para UserService
✅ chore: atualiza dependências do projeto
✅ perf: otimiza query de busca de usuários
```

### Mensagens com Escopo

```
feat(auth): implementa refresh token
fix(api): corrige CORS headers
docs(readme): adiciona instruções de deploy
style(components): formata componentes React
```

## Equivalente Manual

O script automatiza estes comandos:

```bash
# Ver status
git status

# Adicionar arquivos
git add .

# Criar commit
git commit -m "mensagem"

# Descobrir branch
git rev-parse --abbrev-ref HEAD

# Fazer push
git push origin <branch>
```

## Vantagens do Script

1. ✅ **Automação**: Economiza tempo com comandos repetitivos
2. ✅ **Validação**: Garante que está em repositório Git
3. ✅ **Feedback Visual**: Emojis e cores facilitam compreensão
4. ✅ **Detecção de Branch**: Não precisa especificar branch
5. ✅ **Interativo**: Solicita mensagem de commit
6. ✅ **Status Visual**: Mostra o que será commitado

## Requisitos

- Git instalado e configurado
- Repositório Git inicializado
- Remote `origin` configurado
- Permissões de push no repositório

## Customização

### Adicionar Confirmação

```bash
# Após git add .
read -p "Deseja continuar com o commit? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "❌ Operação cancelada"
  exit 0
fi
```

### Adicionar Validação de Mensagem

```bash
# Validar tamanho mínimo
if [ ${#mensagem} -lt 10 ]; then
  echo "⚠️  Mensagem muito curta (mínimo 10 caracteres)"
  exit 1
fi
```

### Push Forçado (USE COM CUIDADO)

```bash
# Substituir a linha de push por:
git push origin "$branch" --force-with-lease
```

## Scripts Relacionados

- **git-push-faculdade.sh**: Versão para remote `faculdade`

## Comparação de Scripts

| Aspecto           | git-push-origin.sh  | git-push-faculdade.sh     |
| ----------------- | ------------------- | ------------------------- |
| Remote de destino | origin              | faculdade                 |
| Funcionalidade    | Idêntica            | Idêntica                  |
| Uso típico        | Repositório pessoal | Repositório institucional |

## Observações

- Usa `git add .` - adiciona **todos** os arquivos modificados
- Branch é detectada automaticamente
- Ideal para workflow pessoal rápido
- Para mais controle, use comandos Git manualmente
