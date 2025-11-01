# react-router-v7.sh

## Descrição

Script completo para criar um projeto React com Vite, TypeScript, React Router v7, Tailwind CSS, ESLint e Prettier, totalmente configurado e pronto para desenvolvimento.

## Funcionalidade

### 1. Criação do Projeto Base

- **Vite**: Build tool ultra-rápido
- **React**: Biblioteca UI
- **TypeScript**: Tipagem estática
- Template `react-ts`

### 2. React Router v7

Instala a versão mais recente do React Router:

- `@react-router/react` - Core do React Router
- `@react-router/dom` - Implementação para web
- `@react-router/dev` - Ferramentas de desenvolvimento
- `vite-tsconfig-paths` - Suporte a path aliases

### 3. Tailwind CSS

- Instalação completa do Tailwind
- PostCSS e Autoprefixer
- Plugin `@tailwindcss/vite`
- Configuração inicial com `tailwind.config.js`

### 4. ESLint + Prettier

Configuração completa de linting e formatação:

**ESLint Plugins:**

- `@typescript-eslint/eslint-plugin`
- `@typescript-eslint/parser`
- `eslint-plugin-react`
- `eslint-plugin-react-hooks`
- `eslint-plugin-simple-import-sort` - Ordena imports
- `eslint-plugin-prettier` - Integração Prettier

**Prettier Plugins:**

- `prettier-plugin-tailwindcss` - Ordena classes Tailwind

### 5. Estrutura de Pastas

```
projeto/
├── src/
│   ├── pages/           # Páginas da aplicação
│   │   ├── Home.tsx
│   │   └── About.tsx
│   ├── components/      # Componentes reutilizáveis
│   ├── App.tsx          # Layout principal
│   ├── routes.tsx       # Configuração de rotas
│   ├── main.tsx         # Entry point
│   └── index.css        # Estilos Tailwind
└── .vscode/
    └── settings.json    # Config VSCode
```

### 6. Configuração de Rotas

Cria sistema de rotas com:

- Layout principal com navegação
- Página Home
- Página About
- Nested routes com `<Outlet />`

### 7. VSCode Settings

- Formatação automática ao salvar
- Prettier como formatter padrão
- ESLint auto-fix ao salvar
- EOL Unix (LF)

## Como Usar

### Pré-requisitos

```bash
# pnpm instalado
npm install -g pnpm
```

### Executar o script

```bash
./src/react-router-v7.sh
```

ou

```bash
bash src/react-router-v7.sh
```

## Fluxo Interativo

```
📦 Digite o nome do seu projeto: meu-projeto

📁 Criando projeto com Vite + React + TypeScript...
📦 Instalando dependências do React Router...
🔧 Instalando dev dependencies...
🎨 Instalando TailwindCSS...
🧹 Instalando ESLint, Prettier e plugins...
📂 Criando estrutura de pastas...
🛠️ Configurando Vite...
📝 Criando arquivos de configuração...
📄 Criando arquivos React Router padrão...

✅ Projeto "meu-projeto" criado com sucesso!
🚀 Acesse: cd meu-projeto && pnpm run dev
```

## Estrutura de Arquivos Criados

### vite.config.ts

```typescript
import { defineConfig } from "vite";
import tsconfigPaths from "vite-tsconfig-paths";
import tailwindcss from "@tailwindcss/vite";
import { reactRouter } from "@react-router/dev/vite";

export default defineConfig({
  plugins: [tailwindcss(), reactRouter(), tsconfigPaths()],
});
```

### src/routes.tsx

```typescript
import {
  createBrowserRouter,
  createRoutesFromElements,
  Route,
} from "react-router-dom";
import App from "./App";
import Home from "./pages/Home";
import About from "./pages/About";

export const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path="/" element={<App />}>
      <Route index element={<Home />} />
      <Route path="about" element={<About />} />
    </Route>
  )
);
```

### src/App.tsx

```typescript
import { Outlet, Link } from "react-router-dom";

export default function App() {
  return (
    <div className="p-6">
      <nav className="space-x-4">
        <Link to="/" className="text-blue-500 underline">
          Home
        </Link>
        <Link to="/about" className="text-green-500 underline">
          About
        </Link>
      </nav>
      <div className="mt-6">
        <Outlet />
      </div>
    </div>
  );
}
```

### src/main.tsx

```typescript
import React from "react";
import ReactDOM from "react-dom/client";
import { RouterProvider } from "react-router-dom";
import "./index.css";
import { router } from "./routes";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);
```

### .eslintrc.js

```javascript
module.exports = {
  root: true,
  parser: "@typescript-eslint/parser",
  plugins: [
    "react",
    "react-hooks",
    "@typescript-eslint",
    "simple-import-sort",
    "prettier",
  ],
  extends: [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react-hooks/recommended",
    "plugin:prettier/recommended",
  ],
  rules: {
    "prettier/prettier": "error",
    "simple-import-sort/imports": "error",
    "simple-import-sort/exports": "error",
    "react/react-in-jsx-scope": "off",
    "react/prop-types": "off",
  },
};
```

### .prettierrc.json

```json
{
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
  "plugins": ["prettier-plugin-tailwindcss"]
}
```

## Comandos Disponíveis

### Desenvolvimento

```bash
pnpm dev          # Inicia servidor dev (localhost:5173)
pnpm build        # Build para produção
pnpm preview      # Preview do build
```

### Code Quality

```bash
pnpm lint         # Executa ESLint
pnpm format       # Formata código com Prettier
```

## Adicionar Novas Rotas

### 1. Criar Página

```typescript
// src/pages/Contact.tsx
export default function Contact() {
  return <h1>Contato</h1>;
}
```

### 2. Adicionar Rota

```typescript
// src/routes.tsx
import Contact from "./pages/Contact";

export const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path="/" element={<App />}>
      <Route index element={<Home />} />
      <Route path="about" element={<About />} />
      <Route path="contact" element={<Contact />} /> {/* Nova rota */}
    </Route>
  )
);
```

### 3. Adicionar Link

```typescript
// src/App.tsx
<nav className="space-x-4">
  <Link to="/">Home</Link>
  <Link to="/about">About</Link>
  <Link to="/contact">Contact</Link> {/* Novo link */}
</nav>
```

## Rotas Avançadas

### Rotas Dinâmicas

```typescript
<Route path="users/:id" element={<UserProfile />} />
```

```typescript
// src/pages/UserProfile.tsx
import { useParams } from "react-router-dom";

export default function UserProfile() {
  const { id } = useParams();
  return <h1>User ID: {id}</h1>;
}
```

### Rotas Protegidas

```typescript
// src/components/ProtectedRoute.tsx
import { Navigate } from "react-router-dom";

export function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const isAuthenticated = false; // sua lógica aqui

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  return children;
}
```

```typescript
// src/routes.tsx
<Route
  path="dashboard"
  element={
    <ProtectedRoute>
      <Dashboard />
    </ProtectedRoute>
  }
/>
```

### Rotas Aninhadas

```typescript
<Route path="dashboard" element={<DashboardLayout />}>
  <Route index element={<DashboardHome />} />
  <Route path="profile" element={<Profile />} />
  <Route path="settings" element={<Settings />} />
</Route>
```

## Navegação Programática

```typescript
import { useNavigate } from "react-router-dom";

function MyComponent() {
  const navigate = useNavigate();

  const handleClick = () => {
    navigate("/about");
  };

  return <button onClick={handleClick}>Go to About</button>;
}
```

## Tailwind CSS

### Adicionar ao Componente

```typescript
export default function Home() {
  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="max-w-md p-6 bg-white rounded-lg shadow-lg">
        <h1 className="text-3xl font-bold text-blue-600">Welcome Home</h1>
        <p className="mt-4 text-gray-600">This is your homepage.</p>
      </div>
    </div>
  );
}
```

### Customizar Tema

Edite `tailwind.config.js`:

```javascript
export default {
  theme: {
    extend: {
      colors: {
        primary: "#3B82F6",
        secondary: "#10B981",
      },
    },
  },
};
```

## Extensões VSCode Recomendadas

- **ESLint** (dbaeumer.vscode-eslint)
- **Prettier** (esbenp.prettier-vscode)
- **Tailwind CSS IntelliSense** (bradlc.vscode-tailwindcss)
- **Error Lens** (usernamehw.errorlens)

## Requisitos

- Node.js 18+
- pnpm 8+

## Troubleshooting

### Erro: Module not found

```bash
# Reinstalar dependências
rm -rf node_modules pnpm-lock.yaml
pnpm install
```

### ESLint/Prettier não funcionam

```bash
# Recarregar VSCode
Ctrl+Shift+P → "Reload Window"
```

### Imports não funcionam

Verifique `tsconfig.json`:

```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
```

## Observações

- ⚡ Vite oferece HMR ultra-rápido
- 🎯 React Router v7 com novas features
- 🎨 Tailwind CSS configurado e pronto
- 📏 ESLint + Prettier para código consistente
- 🔧 TypeScript para type safety
- 📦 pnpm para gerenciamento eficiente
