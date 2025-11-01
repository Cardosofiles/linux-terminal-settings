# docker-login.sh

## Descrição

Script automatizado para realizar autenticação no Docker Hub e exibir informações sobre containers e imagens.

## Funcionalidade

Este script realiza as seguintes operações:

1. **Validação do Ambiente**

   - Verifica se o Docker está instalado
   - Verifica se o daemon do Docker está em execução

2. **Autenticação**

   - Realiza login no Docker Hub usando credenciais pré-configuradas
   - Utiliza token de acesso pessoal (PAT) para autenticação segura

3. **Informações do Sistema**
   - Lista imagens Docker locais
   - Exibe containers em execução
   - Lista containers parados

## Como Usar

### Executar o script

```bash
./src/docker-login.sh
```

ou

```bash
bash src/docker-login.sh
```

## 🔐 Configuração de Credenciais

**IMPORTANTE**: Este script usa variáveis de ambiente para segurança.

### Configurar Credenciais Antes de Usar

#### Opção 1: Variáveis de Ambiente Temporárias

```bash
export DOCKER_USERNAME="seu-usuario"
export DOCKER_TOKEN="seu-token-aqui"
./src/docker-login.sh
```

#### Opção 2: Adicionar ao ~/.zshrc (Permanente)

```bash
# Adicionar ao final do ~/.zshrc
echo 'export DOCKER_USERNAME="seu-usuario"' >> ~/.zshrc
echo 'export DOCKER_TOKEN="seu-token-aqui"' >> ~/.zshrc

# Recarregar configuração
source ~/.zshrc
```

#### Opção 3: Usar Arquivo .env (Mais Seguro)

```bash
# Criar arquivo de credenciais
cat > ~/.docker-credentials << EOF
export DOCKER_USERNAME="seu-usuario"
export DOCKER_TOKEN="seu-token-aqui"
EOF

# Proteger o arquivo
chmod 600 ~/.docker-credentials

# Adicionar ao ~/.zshrc
echo 'source ~/.docker-credentials' >> ~/.zshrc
source ~/.zshrc
```

### ⚠️ Boas Práticas de Segurança:

1. ✅ **Nunca commitar tokens** em repositórios
2. ✅ **Usar variáveis de ambiente** (como implementado)
3. ✅ **Proteger arquivos de credenciais** com `chmod 600`
4. ✅ **Adicionar ao .gitignore**: `.env`, `*-credentials`
5. ✅ **Revogar tokens antigos** se expostos
6. ✅ **Usar Docker Credential Helpers** em produção

## Saída Esperada

```
🚀 Script de autenticação com o Docker Hub 🔥
🔐 Realizando login no Docker Hub...
✅ Login realizado com sucesso!
📦 Listando imagens locais:
REPOSITORY          TAG        SIZE
node                20-alpine  145MB
postgres            latest     379MB

🧱 Containers em execução:
NAMES               IMAGE             STATUS
myapp               node:20-alpine    Up 2 hours

📦 Containers parados:
NAMES               IMAGE             STATUS
oldapp              node:18           Exited (0) 2 days ago

✨ Pronto para usar o Docker!
```

## Mensagens de Erro

### Docker não instalado

```
❌ Docker não está instalado. Instale antes de continuar.
```

### Docker não está rodando

```
❌ Docker não está rodando. Inicie o serviço e tente novamente.
```

### Falha no login

```
❌ Falha no login. Verifique o token ou usuário.
```

## Requisitos

- Docker instalado e configurado
- Docker daemon em execução
- Conexão com a internet
- Token de acesso válido do Docker Hub

## Cores no Terminal

O script utiliza cores ANSI para melhor visualização:

- 🔴 Vermelho: Erros
- 🟢 Verde: Sucesso
- 🟡 Amarelo: Avisos e informações
