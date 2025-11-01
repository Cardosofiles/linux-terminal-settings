# next-shadcn-prettierrc.sh

## Descrição

Script automatizado para criar um projeto Next.js com TypeScript, Tailwind CSS, Shadcn UI, ESLint e Prettier, incluindo integração opcional com GitHub.

## Funcionalidade

### 1. Criação do Projeto Next.js

Inicializa projeto com:

- ✅ **TypeScript**: Tipagem estática
- ✅ **Tailwind CSS**: Framework CSS utility-first
- ✅ **App Router**: Novo sistema de roteamento do Next.js
- ✅ **src/ directory**: Organização com diretório src
- ✅ **ESLint**: Linter habilitado
- ✅ **Turbopack**: Bundler de alta performance
- ✅ **Import alias**: `@/*` para imports absolutos

### 2. Shadcn UI

- Instala dependências core: `@shadcn/ui`, `clsx`, `tailwind-variants`
- Inicializa configuração interativa
- Permite escolher tema de cores:
  - Neutral
  - Gray
  - Zinc
  - Stone
  - Slate

### 3. Prettier + Plugin Tailwind

Instala e configura:

- **Prettier**: Code formatter
- **prettier-plugin-tailwindcss**: Ordena classes Tailwind automaticamente

#### Configuração Prettier

```json
{
  "singleQuote": true,
  "jsxSingleQuote": false,
  "semi": false,
  "trailingComma": "es5",
  "arrowParens": "avoid",
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "bracketSameLine": false,
  "plugins": ["prettier-plugin-tailwindcss"],
  "tailwindConfig": "./tailwind.config.js"
}
```

### 4. VSCode Settings

Configuração automática do VSCode:

- Formatação ao salvar
- Prettier como formatter padrão
- ESLint auto-fix ao salvar
- Validação de arquivos JS/TS/React
- EOL Unix (LF)
- Final newline automático

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
./src/next-shadcn-prettierrc.sh
```

ou

```bash
bash src/next-shadcn-prettierrc.sh
```

## Fluxo Interativo

### 1. Nome do Projeto

```
🚀 Criador de projetos Next.js com pnpm + Tailwind + ESLint + Prettier + Shadcn + GitHub
📦 Qual o nome do projeto? minha-app
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
🔐 Qual o nome do repositório no GitHub (ou ENTER para 'minha-app')?
```

### 4. Finalização

```
✅ Projeto criado com sucesso!
🎉 Projeto 'minha-app' criado e pronto para desenvolvimento!

👉 Rode com: pnpm dev
```

## Estrutura do Projeto

```
minha-app/
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
│   └── settings.json        # Config VSCode + Prettier
├── public/
├── .eslintrc.json           # Config ESLint
├── .prettierrc.json         # Config Prettier
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
pnpm lint         # Executa ESLint
```

### Formatação

```bash
# Formatar com Prettier
pnpm prettier --write .

# Checar formatação
pnpm prettier --check .

# ESLint fix
pnpm eslint . --fix
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

## Personalização

### Modificar Prettier

Edite `.prettierrc.json`:

```json
{
  "printWidth": 120, // Linha mais longa
  "semi": true, // Usar ponto-e-vírgula
  "singleQuote": false, // Usar aspas duplas
  "tabWidth": 4, // 4 espaços
  "trailingComma": "all" // Vírgula em todos lugares
}
```

### Modificar ESLint

Edite `.eslintrc.json`:

```json
{
  "extends": ["next/core-web-vitals", "prettier"],
  "rules": {
    "react/no-unescaped-entities": "off",
    "@next/next/no-page-custom-font": "off"
  }
}
```

### Scripts Úteis no package.json

```json
{
  "scripts": {
    "dev": "next dev --turbopack",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "lint:fix": "eslint . --fix",
    "type-check": "tsc --noEmit"
  }
}
```

## Prettier + Tailwind Plugin

O plugin `prettier-plugin-tailwindcss` organiza automaticamente as classes Tailwind:

### Antes

```tsx
<div className="text-white px-4 py-2 bg-blue-500 rounded-lg hover:bg-blue-600">
```

### Depois (automaticamente)

```tsx
<div className="rounded-lg bg-blue-500 px-4 py-2 text-white hover:bg-blue-600">
```

## Extensões VSCode Recomendadas

### Essenciais

- **ESLint** (dbaeumer.vscode-eslint)
- **Prettier** (esbenp.prettier-vscode)
- **Tailwind CSS IntelliSense** (bradlc.vscode-tailwindcss)

### Opcionais

- **Error Lens** (usernamehw.errorlens)
- **GitLens** (eamodio.gitlens)
- **Pretty TypeScript Errors** (yoavbls.pretty-ts-errors)

## Componentes Shadcn Populares

### Formulários

```bash
pnpm dlx shadcn@latest add form input label textarea select
```

### Layout

```bash
pnpm dlx shadcn@latest add card separator tabs accordion
```

### Feedback

```bash
pnpm dlx shadcn@latest add alert toast dialog sheet
```

### Navegação

```bash
pnpm dlx shadcn@latest add navigation-menu dropdown-menu
```

### Data Display

```bash
pnpm dlx shadcn@latest add table badge avatar
```

## Exemplo de Página

```tsx
// src/app/page.tsx
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

export default function Home() {
  return (
    <main className="container mx-auto p-8">
      <Card className="w-full max-w-md">
        <CardHeader>
          <CardTitle>Bem-vindo</CardTitle>
          <CardDescription>Projeto Next.js com Shadcn UI</CardDescription>
        </CardHeader>
        <CardContent>
          <p>Este é um exemplo de card do Shadcn UI.</p>
        </CardContent>
        <CardFooter>
          <Button className="w-full">Começar</Button>
        </CardFooter>
      </Card>
    </main>
  );
}
```

## Configuração VSCode

O script cria `.vscode/settings.json` automaticamente:

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "eslint.workingDirectories": [{ "mode": "auto" }],
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

## Requisitos

- Node.js 18+ (recomendado: 20+)
- pnpm 8+
- Git (para controle de versão)
- GitHub CLI `gh` (opcional, para criar repo)

## Diferenças do next-shadcn-biome.sh

| Aspecto     | next-shadcn-prettierrc.sh | next-shadcn-biome.sh |
| ----------- | ------------------------- | -------------------- |
| Linter      | ESLint                    | Biome                |
| Formatter   | Prettier                  | Biome                |
| Performance | 🐌 Padrão                 | ⚡ 25x mais rápido   |
| Pacotes     | Mais                      | Menos                |
| Maturidade  | ✅ Estável                | ⚠️ Novo              |
| Plugins     | ✅ Muitos                 | ⚠️ Poucos            |

## Troubleshooting

### Prettier não formata ao salvar

1. Verifique extensão: **Prettier - Code formatter**
2. Recarregue VSCode: `Ctrl+Shift+P` → "Reload Window"
3. Verifique `.vscode/settings.json`

### Conflito ESLint vs Prettier

Instale `eslint-config-prettier`:

```bash
pnpm add -D eslint-config-prettier
```

Adicione no `.eslintrc.json`:

```json
{
  "extends": ["next", "prettier"]
}
```

### Classes Tailwind não são ordenadas

1. Verifique se `prettier-plugin-tailwindcss` está instalado
2. Certifique-se que `tailwindConfig` está no `.prettierrc.json`
3. Recarregue VSCode

### Erro ao criar repo no GitHub

```bash
# Fazer login no GitHub CLI
gh auth login

# Verificar autenticação
gh auth status
```

## Observações

- 📦 Usa pnpm para gerenciamento eficiente de pacotes
- 🎨 Shadcn UI é altamente customizável
- 🚀 Turbopack ativado por padrão (experimental)
- ✨ Prettier + Tailwind plugin mantém código organizado
- 🔧 ESLint + Prettier é a configuração mais comum e madura
- 📝 Configuração VSCode automática para melhor DX
