#!/bin/bash

read -p "📦 Digite o nome do seu projeto: " PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Nome do projeto não pode estar vazio. Abortando."
  exit 1
fi

echo "📁 Criando projeto com Vite + React + TypeScript..."
pnpm create vite@latest "$PROJECT_NAME" --template react-ts
cd "$PROJECT_NAME" || exit

echo "📦 Instalando dependências do React Router..."
pnpm add @react-router/react @react-router/dom react-dom react

echo "🔧 Instalando dev dependencies..."
pnpm add -D @react-router/dev typescript vite @types/react @types/react-dom vite-tsconfig-paths

echo "🎨 Instalando TailwindCSS..."
pnpm add -D tailwindcss postcss autoprefixer @tailwindcss/vite
npx tailwindcss init -p

echo "🧹 Instalando ESLint, Prettier e plugins..."
pnpm add -D eslint prettier \
  eslint-config-prettier eslint-plugin-prettier \
  @typescript-eslint/eslint-plugin @typescript-eslint/parser \
  eslint-plugin-react eslint-plugin-react-hooks \
  eslint-plugin-simple-import-sort prettier-plugin-tailwindcss

echo "📂 Criando estrutura de pastas..."
mkdir -p src/pages src/components .vscode

echo "🛠️ Configurando Vite..."
cat <<EOF > vite.config.ts
import { defineConfig } from 'vite'
import tsconfigPaths from 'vite-tsconfig-paths'
import tailwindcss from '@tailwindcss/vite'
import { reactRouter } from '@react-router/dev/vite'

export default defineConfig({
  plugins: [tailwindcss(), reactRouter(), tsconfigPaths()],
})
EOF

echo "📝 Criando arquivos de configuração..."

# ESLint
cat <<EOF > .eslintrc.js
/** @type {import('eslint').Linter.Config} */
module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
    ecmaFeatures: { jsx: true },
  },
  plugins: [
    'react',
    'react-hooks',
    '@typescript-eslint',
    'simple-import-sort',
    'prettier',
  ],
  extends: [
    'eslint:recommended',
    'plugin:react/recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react-hooks/recommended',
    'plugin:prettier/recommended',
  ],
  rules: {
    'prettier/prettier': 'error',
    'simple-import-sort/imports': 'error',
    'simple-import-sort/exports': 'error',
    'react/react-in-jsx-scope': 'off',
    'react/prop-types': 'off',
  },
  settings: {
    react: { version: 'detect' },
  },
}
EOF

# Prettier
cat <<EOF > .prettierrc.json
{
  "\$schema": "http://json.schemastore.org/prettierrc",
  "singleQuote": true,
  "jsxSingleQuote": false,
  "semi": false,
  "trailingComma": "es5",
  "arrowParens": "avoid",
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "bracketSameLine": false,
  "plugins": ["prettier-plugin-tailwindcss"],
  "tailwindConfig": "./tailwind.config.js"
}
EOF

# VSCode
cat <<EOF > .vscode/settings.json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "eslint.workingDirectories": [{ "mode": "auto" }],
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ],
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "files.eol": "\\\\n",
  "files.insertFinalNewline": true,
  "prettier.enableDebugLogs": false,
  "[typescriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
EOF

echo "📄 Criando arquivos React Router padrão..."

# Home Page
cat <<EOF > src/pages/Home.tsx
export default function Home() {
  return <h1 className="text-2xl font-bold text-blue-600">Página Inicial</h1>
}
EOF

# About Page
cat <<EOF > src/pages/About.tsx
export default function About() {
  return <h1 className="text-2xl font-bold text-green-600">Sobre Nós</h1>
}
EOF

# App Layout
cat <<EOF > src/App.tsx
import { Outlet, Link } from 'react-router-dom'

export default function App() {
  return (
    <div className="p-6">
      <nav className="space-x-4">
        <Link to="/" className="text-blue-500 underline">Home</Link>
        <Link to="/about" className="text-green-500 underline">About</Link>
      </nav>
      <div className="mt-6">
        <Outlet />
      </div>
    </div>
  )
}
EOF

# Rotas
cat <<EOF > src/routes.tsx
import { createBrowserRouter, createRoutesFromElements, Route } from 'react-router-dom'
import App from './App'
import Home from './pages/Home'
import About from './pages/About'

export const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path="/" element={<App />}>
      <Route index element={<Home />} />
      <Route path="about" element={<About />} />
    </Route>
  )
)
EOF

# Main Entry
cat <<EOF > src/main.tsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import { RouterProvider } from 'react-router-dom'
import './index.css'
import { router } from './routes'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
)
EOF

# Tailwind setup
cat <<EOF > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

echo "✅ Projeto \"$PROJECT_NAME\" criado com sucesso!"
echo "🚀 Acesse: cd $PROJECT_NAME && pnpm run dev"
