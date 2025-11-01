# check-version.sh

## Descrição

Script para verificar e exibir as versões de todas as ferramentas de desenvolvimento instaladas no sistema.

## Funcionalidade

Este script realiza uma varredura completa do ambiente de desenvolvimento e exibe as versões instaladas de:

### Ferramentas Java

- **Java**: Versão do JDK/JRE instalado
- **Maven**: Versão do gerenciador de build Maven
- **Gradle**: Versão do gerenciador de build Gradle

### Ferramentas Node.js

- **Node.js**: Versão do runtime Node
- **npm**: Versão do gerenciador de pacotes npm
- **pnpm**: Versão do gerenciador de pacotes pnpm
- **bun**: Versão do runtime/gerenciador Bun

### Outras Linguagens

- **Python**: Versão do Python 3
- **PHP**: Versão do interpretador PHP
- **C#/.NET**: Versão do .NET SDK

### Ferramentas de Containerização

- **Docker**: Versão do Docker Engine
- **Docker Compose**: Versão do Docker Compose

### Ferramentas Adicionais

- **Valet**: Versão do Valet (ambiente de desenvolvimento PHP)

## Como Usar

### Executar o script

```bash
./src/check-version.sh
```

ou

```bash
bash src/check-version.sh
```

## Saída Esperada

O script exibirá uma saída formatada como:

```
🖥  Environment Versions:
Java: 21.0.5
Maven: 3.9.6
Gradle: 8.5
Node: v20.11.0 | npm: 10.2.4 | pnpm: 8.15.1 | bun: 1.0.25
Python: Python 3.11.7
Docker: 24.0.7 | Docker Compose: v2.23.3
PHP: 8.2.15
C#: 8.0.101
Valet: v2.18.0
```

## Observações

- Se alguma ferramenta não estiver instalada, será exibido "Not installed"
- O script não requer privilégios de superusuário
- Útil para verificar o ambiente antes de iniciar projetos
- Pode ser usado em scripts de CI/CD para documentar o ambiente de build

## Requisitos

- Bash shell
- Nenhuma dependência adicional necessária
