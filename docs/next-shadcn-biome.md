# next-shadcn-biome.sh

## Descrição

Script automatizado para criar um projeto Next.js moderno com TypeScript, Tailwind CSS, Shadcn UI e Biome (substituto do ESLint/Prettier), incluindo integração opcional com GitHub.

## Funcionalidade

### 1. Criação do Projeto Next.js

Inicializa projeto com:

- ✅ **TypeScript**: Tipagem estática
- ✅ **Tailwind CSS**: Framework CSS utility-first
- ✅ **App Router**: Novo sistema de roteamento do Next.js
- ✅ **src/ directory**: Organização com diretório src
- ✅ **Turbopack**: Bundler de alta performance
- ✅ **Import alias**: `@/*` para imports absolutos
- ❌ **ESLint**: Desabilitado (usa Biome)

### 2. Shadcn UI

- Instala dependências core: `@shadcn/ui`, `clsx`, `tailwind-variants`
- Inicializa configuração interativa
- Permite escolher tema de cores:
  - Neutral
  - Gray
  - Zinc
  - Stone
  - Slate

### 3. Biome (Linter + Formatter)

Substitui ESLint e Prettier com:

- ⚡ **Performance**: 25x mais rápido
- 🔧 **Tudo-em-um**: Linter + Formatter
- ⚙️ **Zero config**: Funciona out-of-the-box

#### Configuração Biome

```json
{
  "organizeImports": { "enabled": true },
  "formatter": {
    "indentStyle": "space",
    "indentWidth": 2,
    "lineWidth": 80
  },
  "javascript": {
    "formatter": {
      "arrowParentheses": "asNeeded",
      "jsxQuoteStyle": "double",
      "quoteStyle": "single",
      "semicolons": "asNeeded",
      "trailingCommas": "es5"
    }
  },
  "linter": {
    "enabled": true,
    "rules": { "recommended": true }
  }
}
```

### 4. VSCode Settings

Configuração automática do VSCode:

- Formatação ao salvar
- Biome como formatter padrão
- Organização automática de imports
- Suporte para JS, TS e TSX

### 5. Integração Git/GitHub

- Inicialização de repositório Git local
- Commit inicial
- Criação automática de repositório no GitHub
- Push automático

## Como Usar

### Pré-requisitos

```bash
# pnpm instalado
npm install -g pnpm

# GitHub CLI (opcional, para criar repo)
# Linux/WSL:
sudo apt install gh
gh auth login

# macOS:
brew install gh
gh auth login
```

### Executar o script

```bash
./src/next-shadcn-biome.sh
```

ou

```bash
bash src/next-shadcn-biome.sh
```

## Fluxo Interativo

### 1. Nome do Projeto

```
🚀 Criador de projetos Next.js avançado com pnpm + Tailwind + Biome + Shadcn + GitHub
📦 Qual o nome do projeto? meu-app
```

### 2. Seleção de Tema Shadcn

```
⚙️ Inicializando Shadcn UI...
🎨 Ao iniciar, selecione a cor base desejada usando as setas do teclado (⬆️⬇️):
    → Neutral
    → Gray
    → Zinc
    → Stone
    → Slate
```

Use as setas `⬆️⬇️` e `ENTER` para selecionar.

### 3. Git Repository (Opcional)

```
🔗 Deseja criar repositório Git local? (y/n): y
🌐 Deseja criar um repositório no GitHub e fazer push? (y/n): y
🔐 Qual o nome do repositório no GitHub (ou ENTER para 'meu-app')?
```

### 4. Finalização

```
✅ Projeto criado com sucesso!
🎉 Projeto 'meu-app' criado e pronto para desenvolvimento!

👉 Rode com: pnpm dev
```

## Estrutura do Projeto

```
meu-app/
├── src/
│   ├── app/
│   │   ├── layout.tsx
│   │   ├── page.tsx
│   │   └── globals.css
│   ├── components/
│   │   └── ui/              # Componentes Shadcn
│   └── lib/
│       └── utils.ts
├── .vscode/
│   └── settings.json        # Config VSCode + Biome
├── public/
├── biome.json               # Config Biome
├── components.json          # Config Shadcn
├── next.config.ts
├── tailwind.config.ts
├── tsconfig.json
├── package.json
└── .gitignore
```

## Comandos Disponíveis

### Desenvolvimento

```bash
pnpm dev          # Inicia servidor dev (localhost:3000)
pnpm build        # Build para produção
pnpm start        # Inicia servidor de produção
pnpm lint         # Executa Biome linter
```

### Shadcn UI

```bash
# Adicionar componentes
pnpm dlx shadcn@latest add button
pnpm dlx shadcn@latest add card
pnpm dlx shadcn@latest add dialog

# Adicionar múltiplos
pnpm dlx shadcn@latest add button card input
```

### Biome

```bash
# Formatar código
pnpm biome format --write .

# Lint
pnpm biome lint .

# Lint + Fix
pnpm biome check --write .
```

## Personalização

### Adicionar Script ao package.json

```json
{
  "scripts": {
    "dev": "next dev --turbopack",
    "build": "next build",
    "start": "next start",
    "lint": "biome lint .",
    "format": "biome format --write .",
    "check": "biome check --write ."
  }
}
```

### Modificar Tema Shadcn

Edite `src/app/globals.css`:

```css
@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --primary: 221.2 83.2% 53.3%;
    /* ... mais variáveis */
  }
}
```

### Configurar Biome

Edite `biome.json`:

```json
{
  "formatter": {
    "lineWidth": 120, // Aumentar linha
    "indentWidth": 4 // Usar 4 espaços
  }
}
```

## Biome vs ESLint/Prettier

| Aspecto      | Biome              | ESLint + Prettier |
| ------------ | ------------------ | ----------------- |
| Performance  | ⚡ 25x mais rápido | 🐌 Lento          |
| Instalação   | 1 pacote           | 10+ pacotes       |
| Configuração | Mínima             | Complexa          |
| Conflitos    | ✅ Zero            | ❌ Comuns         |
| TypeScript   | ✅ Nativo          | ⚠️ Requer plugins |
| JSON         | ✅ Suportado       | ❌ Não            |

## Componentes Shadcn Comuns

```bash
# Formulários
pnpm dlx shadcn@latest add input
pnpm dlx shadcn@latest add textarea
pnpm dlx shadcn@latest add select
pnpm dlx shadcn@latest add checkbox
pnpm dlx shadcn@latest add radio-group

# Layout
pnpm dlx shadcn@latest add card
pnpm dlx shadcn@latest add separator
pnpm dlx shadcn@latest add tabs

# Feedback
pnpm dlx shadcn@latest add alert
pnpm dlx shadcn@latest add toast
pnpm dlx shadcn@latest add dialog
pnpm dlx shadcn@latest add alert-dialog

# Navegação
pnpm dlx shadcn@latest add navigation-menu
pnpm dlx shadcn@latest add dropdown-menu
pnpm dlx shadcn@latest add menubar
```

## Exemplo de Uso

### Criar Página com Componentes Shadcn

```tsx
// src/app/page.tsx
import { Button } from "@/components/ui/button";
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";

export default function Home() {
  return (
    <div className="container mx-auto p-4">
      <Card>
        <CardHeader>
          <CardTitle>Bem-vindo</CardTitle>
        </CardHeader>
        <CardContent>
          <Button>Clique aqui</Button>
        </CardContent>
      </Card>
    </div>
  );
}
```

## Requisitos

- Node.js 18+ (recomendado: 20+)
- pnpm 8+
- Git (para controle de versão)
- GitHub CLI `gh` (opcional, para criar repo)

## Diferenças do next-shadcn-prettierrc.sh

| Aspecto          | next-shadcn-biome.sh | next-shadcn-prettierrc.sh |
| ---------------- | -------------------- | ------------------------- |
| Linter/Formatter | Biome                | ESLint + Prettier         |
| ESLint           | ❌ Desabilitado      | ✅ Habilitado             |
| Performance      | ⚡ Muito rápido      | 🐌 Mais lento             |
| Pacotes          | Menos                | Mais                      |
| Conflitos        | ✅ Zero              | ⚠️ Possíveis              |

## Troubleshooting

### Erro: pnpm não encontrado

```bash
npm install -g pnpm
```

### Erro: gh command not found

```bash
# Instalar GitHub CLI
sudo apt install gh
gh auth login
```

### Biome não formata automaticamente

1. Verifique extensão: **Biome** (biomejs.biome)
2. Recarregue VSCode: `Ctrl+Shift+P` → "Reload Window"
3. Verifique `.vscode/settings.json`

### Erro na criação do projeto

```bash
# Limpar cache pnpm
pnpm store prune

# Tentar novamente
./src/next-shadcn-biome.sh
```

## Observações

- ⚡ Biome é significativamente mais rápido que Prettier
- 🎨 Shadcn UI é altamente customizável
- 📦 Usa pnpm para gerenciamento eficiente de pacotes
- 🚀 Turbopack ativado por padrão (modo experimental)
- 🔧 Configuração VSCode automática para melhor DX
