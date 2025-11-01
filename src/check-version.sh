#!/usr/bin/env bash
# ==============================
# check-version.sh - mostra versões de dev tools
# ==============================

echo ""
echo "🖥  Environment Versions:"

# -------------------
# Java / Maven / Gradle
# -------------------
command -v java >/dev/null && java_version=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}') || java_version="Not installed"
echo "Java: $java_version"

command -v mvn >/dev/null && maven_version=$(mvn -v 2>/dev/null | head -n 1 | awk '{print $3}') || maven_version="Not installed"
echo "Maven: $maven_version"

command -v gradle >/dev/null && gradle_version=$(gradle -v 2>/dev/null | grep 'Gradle' | awk '{print $2}') || gradle_version="Not installed"
echo "Gradle: $gradle_version"

# -------------------
# Node & package managers
# -------------------
command -v node >/dev/null && node_version=$(node -v) || node_version="Not installed"
command -v npm >/dev/null && npm_version=$(npm -v) || npm_version="Not installed"
command -v pnpm >/dev/null && pnpm_version=$(pnpm -v) || pnpm_version="Not installed"
command -v bun >/dev/null && bun_version=$(bun -v) || bun_version="Not installed"
echo "Node: $node_version | npm: $npm_version | pnpm: $pnpm_version | bun: $bun_version"

# -------------------
# Python
# -------------------
command -v python3 >/dev/null && python_version=$(python3 --version 2>/dev/null) || python_version="Not installed"
echo "Python: $python_version"

# -------------------
# Docker / Docker Compose
# -------------------
command -v docker >/dev/null && docker_version=$(docker --version | awk '{print $3}' | sed 's/,//') || docker_version="Not installed"
command -v docker-compose >/dev/null && docker_compose_version=$(docker-compose --version | awk '{print $4}' | sed 's/,//') || docker_compose_version="Not installed"
echo "Docker: $docker_version | Docker Compose: $docker_compose_version"

# -------------------
# PHP
# -------------------
command -v php >/dev/null && php_version=$(php -v | head -n1 | awk '{print $2}') || php_version="Not installed"
echo "PHP: $php_version"

# -------------------
# C# / .NET
# -------------------
command -v dotnet >/dev/null && dotnet_version=$(dotnet --version) || dotnet_version="Not installed"
echo "C#: $dotnet_version"

# -------------------
# Valet (assumindo valet-linux)
# -------------------
command -v valet >/dev/null && valet_version=$(valet --version 2>/dev/null) || valet_version="Not installed"
echo "Valet: $valet_version"

echo ""
