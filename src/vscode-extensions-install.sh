#!/bin/bash
echo "Instalando extensões do VSCode..."
while read extension; do
  code --install-extension "$extension"
done < vscode-extensions.txt
echo "Tudo instalado com sucesso!"
