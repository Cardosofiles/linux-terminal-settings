# restart-docker.sh

## Descrição

Script para reiniciar containers Docker com rebuild completo e visualização de logs em tempo real da aplicação.

## Funcionalidade

### 1. Para Containers Existentes

- Executa `docker compose down`
- Remove containers, mas preserva volumes (dados não são perdidos)

### 2. Rebuild e Inicialização

- Reconstrói imagens com `--build`
- Inicia containers em modo detached (`-d`)
- Aplica mudanças do código/Dockerfile

### 3. Visualização de Logs

- Aguarda 2 segundos para containers iniciarem
- Conecta ao container específico (`todolist-api`)
- Exibe logs em tempo real do arquivo `/logs/app.log`
- Usa `tail -f` para acompanhar novos logs

## Como Usar

### Executar o script

```bash
./src/restart-docker.sh
```

ou

```bash
bash src/restart-docker.sh
```

## Fluxo de Execução

```
🧨 Parando containers existentes...
[+] Running 3/3
 ✔ Container todolist-api     Removed
 ✔ Container todolist-db      Removed
 ✔ Container todolist-pgadmin Removed

🚀 Rebuild e inicialização em background...
[+] Building 12.3s (14/14) FINISHED
[+] Running 3/3
 ✔ Container todolist-db      Started
 ✔ Container todolist-pgadmin Started
 ✔ Container todolist-api     Started

✅ Containers atualizados e rodando!

📜 Exibindo logs em tempo real da aplicação:
(Pressione Ctrl+C para parar de visualizar os logs)

2024-11-01 10:30:15 INFO  Server started on port 3000
2024-11-01 10:30:16 INFO  Connected to database
2024-11-01 10:30:17 INFO  Listening on http://localhost:3000
```

## Quando Usar

### 1. Após Mudanças no Código

```bash
# Editou arquivos da aplicação
vim src/index.ts

# Reinicia containers com novo código
./src/restart-docker.sh
```

### 2. Após Mudanças no Dockerfile

```bash
# Modificou Dockerfile
vim Dockerfile

# Reconstrói imagem
./src/restart-docker.sh
```

### 3. Após Mudanças no docker-compose.yml

```bash
# Alterou configurações
vim docker-compose.yml

# Aplica mudanças
./src/restart-docker.sh
```

### 4. Containers Travados ou Com Problemas

```bash
# Limpa e reinicia tudo
./src/restart-docker.sh
```

## Estrutura Esperada

O script assume um projeto com:

### docker-compose.yml

```yaml
services:
  todolist-api:
    build: .
    container_name: todolist-api
    ports:
      - "3000:3000"
    volumes:
      - ./logs:/logs
```

### Sistema de Logs

```bash
# Dentro do container, logs vão para:
/logs/app.log
```

## Personalização

### Mudar Nome do Container

Edite a última linha do script:

```bash
# De:
docker exec -it todolist-api tail -f /logs/app.log

# Para:
docker exec -it seu-container tail -f /logs/app.log
```

### Mudar Caminho dos Logs

```bash
docker exec -it todolist-api tail -f /caminho/para/seus/logs.log
```

### Múltiplos Logs

```bash
# Ver logs de múltiplos containers
docker compose logs -f
```

### Apenas Logs Recentes

```bash
# Últimas 100 linhas
docker exec -it todolist-api tail -n 100 -f /logs/app.log
```

## Cores no Terminal

O script usa cores ANSI para melhor visualização:

- 🔴 **Vermelho**: Operações de parada
- 🔵 **Azul**: Operações de build/start
- 🟢 **Verde**: Sucesso
- 🟡 **Amarelo**: Informações/logs

## Comandos Equivalentes

### Sem o Script

```bash
# Para containers
docker compose down

# Rebuild e inicia
docker compose up -d --build

# Ver logs
docker logs -f todolist-api
# ou
docker exec -it todolist-api tail -f /logs/app.log
```

## Vantagens do Script

1. ✅ **Automação**: Um comando para tudo
2. ✅ **Feedback Visual**: Emojis e cores
3. ✅ **Logs Automáticos**: Conecta automaticamente aos logs
4. ✅ **Rebuild Garantido**: Sempre reconstrói imagens
5. ✅ **Tempo de Espera**: Aguarda containers iniciarem

## Requisitos

- Docker instalado e rodando
- Docker Compose configurado
- Arquivo `docker-compose.yml` no diretório
- Container nomeado `todolist-api`
- Logs sendo escritos em `/logs/app.log`

## Parar de Ver Logs

Para sair da visualização de logs:

```
Ctrl + C
```

⚠️ Isso **não para** o container, apenas sai da visualização.

## Ver Logs Novamente

```bash
docker logs -f todolist-api
```

ou

```bash
docker exec -it todolist-api tail -f /logs/app.log
```

## Comandos Docker Úteis

### Ver Containers Rodando

```bash
docker ps
```

### Ver Todos os Containers

```bash
docker ps -a
```

### Parar Containers

```bash
docker compose down
```

### Ver Logs de Todos

```bash
docker compose logs -f
```

### Executar Comando no Container

```bash
docker exec -it todolist-api bash
```

### Ver Uso de Recursos

```bash
docker stats
```

## Troubleshooting

### Erro: Container não encontrado

```
Error: No such container: todolist-api
```

**Solução**: Verifique o nome do container no `docker-compose.yml`

### Erro: docker-compose.yml não encontrado

```
ERROR: Can't find a suitable configuration file
```

**Solução**: Execute o script no diretório que contém `docker-compose.yml`

### Logs não aparecem

```bash
# Verificar se arquivo existe
docker exec -it todolist-api ls -la /logs/

# Verificar conteúdo
docker exec -it todolist-api cat /logs/app.log
```

### Container não inicia

```bash
# Ver logs de inicialização
docker logs todolist-api

# Ver todos os logs
docker compose logs
```

### Build falha

```bash
# Ver erro completo
docker compose up --build
```

## Limpeza Profunda

Para limpeza completa (⚠️ remove volumes):

```bash
# Para e remove tudo
docker compose down -v

# Remove imagens órfãs
docker system prune -a

# Rebuild do zero
docker compose up -d --build
```

## Observações

- ⚠️ O script assume container específico (`todolist-api`)
- ⚠️ Assume logs em `/logs/app.log`
- ✅ Preserva volumes de dados
- ✅ Reconstrói imagens sempre
- 🔄 Útil para desenvolvimento com mudanças frequentes
- 📊 Permite monitorar aplicação em tempo real
