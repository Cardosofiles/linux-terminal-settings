#!/bin/bash

# Cores
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${RED}🧨 Parando containers existentes...${RESET}"
docker compose down

echo -e "${BLUE}🚀 Rebuild e inicialização em background...${RESET}"
docker compose up -d --build

echo -e "${GREEN}✅ Containers atualizados e rodando!${RESET}"

echo -e "${YELLOW}📜 Exibindo logs em tempo real da aplicação:${RESET}"
echo -e "${BLUE}(Pressione Ctrl+C para parar de visualizar os logs)\n${RESET}"

sleep 2

docker exec -it todolist-api tail -f /logs/app.log
