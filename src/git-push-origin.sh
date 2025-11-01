#!/bin/bash

# Verifica se está em um repositório Git
if [ ! -d .git ]; then
  echo "❌ Você não está em um repositório Git!"
  exit 1
fi

# Mostra o status atual
echo "📦 Status do repositório:"
git status

# Pergunta a mensagem do commit
read -p "✏️  Digite a mensagem do commit: " mensagem

# Verifica se a mensagem está vazia
if [ -z "$mensagem" ]; then
  echo "⚠️  A mensagem do commit não pode estar vazia!"
  exit 1
fi

# Adiciona todas as alterações
echo "➕ Adicionando arquivos..."
git add .

# Faz o commit
echo "📝 Criando commit..."
git commit -m "$mensagem"

# Descobre a branch atual
branch=$(git rev-parse --abbrev-ref HEAD)

# Faz o push
echo "🚀 Enviando para a branch '$branch'..."
git push origin "$branch"

echo "✅ Push realizado com sucesso!"
