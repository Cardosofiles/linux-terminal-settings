#!/bin/bash

# Limpa o terminal
clear

# Funções de cor
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem cor

echo -e "${YELLOW}🚀 Script de autenticação com o Docker Hub 🔥${NC}"

# Verifica se o Docker está instalado
if ! command -v docker &> /dev/null
then
    echo -e "${RED}❌ Docker não está instalado. Instale antes de continuar.${NC}"
    exit 1
fi

# Verifica se o daemon do Docker está rodando
if ! docker info &> /dev/null
then
    echo -e "${RED}❌ Docker não está rodando. Inicie o serviço e tente novamente.${NC}"
    exit 1
fi

# Autenticação
echo -e "${YELLOW}🔐 Realizando login no Docker Hub...${NC}"

# Lê credenciais de variáveis de ambiente
if [ -z "$DOCKER_USERNAME" ] || [ -z "$DOCKER_TOKEN" ]; then
    echo -e "${RED}❌ Configure as variáveis de ambiente DOCKER_USERNAME e DOCKER_TOKEN${NC}"
    echo -e "${YELLOW}💡 Exemplo:${NC}"
    echo -e "   export DOCKER_USERNAME='seu-usuario'"
    echo -e "   export DOCKER_TOKEN='seu-token'"
    echo -e "   ${YELLOW}Ou adicione no ~/.zshrc:${NC}"
    echo -e "   echo 'export DOCKER_USERNAME=\"seu-usuario\"' >> ~/.zshrc"
    echo -e "   echo 'export DOCKER_TOKEN=\"seu-token\"' >> ~/.zshrc"
    exit 1
fi

echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Verifica o sucesso do login
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Login realizado com sucesso!${NC}"
else
    echo -e "${RED}❌ Falha no login. Verifique o token ou usuário.${NC}"
    exit 1
fi

# Lista imagens locais como feedback
echo -e "${YELLOW}📦 Listando imagens locais:${NC}"
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"

# Lista containers ativos
echo -e "${YELLOW}🧱 Containers em execução:${NC}"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

# Lista containers inativos
echo -e "${YELLOW}📦 Containers parados:${NC}"
docker ps -a --filter "status=exited" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

echo -e "${GREEN}✨ Pronto para usar o Docker!${NC}"
