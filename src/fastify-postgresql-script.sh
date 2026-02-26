#!/bin/bash

clear
echo "🚀 Criador de API Fastify com Docker, Prisma 7 (Driver Nativo), PostgreSQL, ESLint 9 e Prettier"

read -p "📦 Digite o nome do projeto: " project_name
project_name="${project_name//_/-}" 

if [[ ! "$project_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "❌ Nome do projeto inválido. Use apenas letras, números, hífens ou underscores."
  exit 1
fi

mkdir "$project_name"
cd "$project_name" || exit 1

# 🧱 Inicializa projeto Node
echo -e "\n🧱 Inicializando projeto Node.js com TypeScript e Fastify 🔥🚀..."

# Cria package.json otimizado
cat > package.json <<EOF
{
  "name": "$project_name",
  "version": "1.0.0",
  "type": "module",
  "main": "dist/server.js",
  "scripts": {
    "dev": "tsx watch src/server.ts",
    "build": "tsc && tsc-alias",
    "start": "node dist/server.js",
    "check": "tsc --noEmit",
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "format": "prettier --write \"src/**/*.ts\"",
    "db:generate": "prisma generate",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio",
    "docker:up": "docker compose up -d",
    "docker:stop": "docker compose stop",
    "docker:down": "docker compose down",
    "docker:clean": "docker compose down -v",
    "docker:logs": "docker compose logs -f"
  },
  "packageManager": "pnpm@10.11.0"
}
EOF

# Instalando dependências
pnpm add fastify @fastify/cors @fastify/helmet @fastify/swagger @fastify/swagger-ui @prisma/client dotenv zod fastify-type-provider-zod pg @prisma/adapter-pg
pnpm add -D typescript tsx @types/node @types/pg prisma pino-pretty tsc-alias eslint @eslint/js typescript-eslint eslint-config-prettier eslint-plugin-prettier prettier

# Configurando tsconfig.json 
cat > tsconfig.json <<EOF
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "lib": ["ES2022"],
    "strict": true,
    "noEmit": false,
    "outDir": "./dist",
    "esModuleInterop": true,
    "resolveJsonModule": true,
    "allowImportingTsExtensions": false,
    "forceConsistentCasingInFileNames": true,
    "skipLibCheck": true,
    "incremental": true,
    "isolatedModules": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    },
    "types": ["node"]
  },
  "include": ["src", "prisma.config.ts"],
  "exclude": ["node_modules", "dist"]
}
EOF

# 🌱 Estrutura de diretórios
mkdir -p src/utils src/routes src/services src/lib src/test src/modules prisma

# 📄 Cria arquivo de ambiente (.env) sem interpolação
cat > .env <<EOF
PORT=3333
NODE_ENV=development

# Credenciais Docker PostgreSQL
POSTGRES_USER=postgres
POSTGRES_PASSWORD=senhaSegura123
POSTGRES_DB=${project_name}_db

# Prisma URL connection 
DATABASE_URL="postgresql://postgres:senhaSegura123@localhost:5432/${project_name}_db?schema=public"

API_URL=http://localhost:3333
CORS_ORIGIN=http://localhost:3000,http://localhost:3333
EOF

# 📄 Prisma 7 - Schema
cat > prisma/schema.prisma <<EOF
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
}

model Example {
  id        String   @id @default(uuid())
  name      String
  createdAt DateTime @default(now()) @map("created_at")
  updatedAt DateTime @updatedAt @map("updated_at")

  @@map("examples")
}
EOF

# 📄 Prisma 7 - prisma.config.ts
cat > prisma.config.ts <<EOF
import "dotenv/config";
import { defineConfig, env } from "prisma/config";
import * as path from "node:path";

export default defineConfig({
  schema: path.join("prisma", "schema.prisma"),
  migrations: {
    path: path.join("prisma", "migrations"),
  },
  datasource: {
    url: env("DATABASE_URL"),
  },
});
EOF

# 📄 Instanciação Global do Prisma
cat > src/lib/prisma.ts <<EOF
import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import { Pool } from 'pg';
import { env } from '@/utils/env.js';

const connectionString = env.DATABASE_URL;
const pool = new Pool({ connectionString });
const adapter = new PrismaPg(pool);

export const prisma = new PrismaClient({
  adapter,
  log: env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
});
EOF

# 📄 Cria docker-compose.yml 
cat > docker-compose.yml <<EOF
services:
  db:
    image: postgres:16-alpine
    container_name: ${project_name}-db
    restart: "no"
    ports:
      - '5432:5432'
    env_file:
      - .env
    environment:
      POSTGRES_USER: \${POSTGRES_USER}
      POSTGRES_PASSWORD: \${POSTGRES_PASSWORD}
      POSTGRES_DB: \${POSTGRES_DB}
      POSTGRES_INITDB_ARGS: "--encoding=UTF-8 --lc-collate=C --lc-ctype=C"
      TZ: "America/Sao_Paulo"
    networks:
      - backend
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "\${POSTGRES_USER}", "-d", "\${POSTGRES_DB}"]
      interval: 2s
      timeout: 2s
      retries: 10
      start_period: 5s
    deploy:
      resources:
        limits:
          memory: 1G
          
volumes:
  pgdata:
    driver: local

networks:
  backend:
    driver: bridge
EOF

# 📄 src/utils/env.ts 
cat > src/utils/env.ts <<EOF
import { z } from "zod";
import "dotenv/config";

const envSchema = z.object({
  PORT: z.coerce.number().default(3333),
  DATABASE_URL: z.string().url().startsWith("postgresql://"),
  NODE_ENV: z.enum(["development", "production", "test"]).default("development"),
  CORS_ORIGIN: z.string().optional(),
  API_URL: z.string().optional(),
});

const result = envSchema.safeParse(process.env);

if (!result.success) {
  console.error("❌ Variáveis de ambiente inválidas:", result.error.format());
  process.exit(1);
}

export const env = result.data;
EOF

# 📄 src/routes/index.ts
cat > src/routes/index.ts <<EOF
import type { FastifyInstance } from 'fastify';
import { getExample } from '@/routes/get-example.js';

export async function registerRoutes(app: FastifyInstance): Promise<void> {
  await app.register(getExample, { prefix: '/api' });
}
EOF

# 📄 src/routes/get-example.ts 
cat > src/routes/get-example.ts <<EOF
import type { FastifyPluginAsyncZod } from 'fastify-type-provider-zod';
import { prisma } from '@/lib/prisma.js';

export const getExample: FastifyPluginAsyncZod = async (app) => {
  app.get('/hello', async () => {
    const count = await prisma.example.count();
    return { message: 'Hello, Fastify with Prisma ORM 7!', records: count };
  });
};
EOF

# 📄 src/server.ts 
echo -e "\n📄 Criando src/server.ts..."
cat > src/server.ts <<EOF
import cors from "@fastify/cors";
import helmet from "@fastify/helmet";
import swagger from "@fastify/swagger";
import swaggerUI from "@fastify/swagger-ui";
import Fastify from "fastify";
import {
  serializerCompiler,
  validatorCompiler,
  type ZodTypeProvider,
} from "fastify-type-provider-zod";

import { registerRoutes } from "@/routes/index.js";
import { env } from "@/utils/env.js";

const config = env.CORS_ORIGIN;
const PORT = env.PORT;
const API_URL = env.API_URL ?? \`http://localhost:\${PORT}\`;

const app = Fastify({
  logger: {
    transport: {
      target: "pino-pretty",
      options: { translateTime: "HH:MM:ss Z", ignore: "pid,hostname", colorize: true },
    },
  },
}).withTypeProvider<ZodTypeProvider>();

app.setSerializerCompiler(serializerCompiler);
app.setValidatorCompiler(validatorCompiler);

await app.register(helmet, { contentSecurityPolicy: false });
await app.register(cors, {
  origin: (origin, cb) => {
    const allowedOrigins = config?.split(",") ?? [];
    if (!origin || allowedOrigins.includes(origin)) {
      cb(null, true);
    } else {
      cb(new Error("Origem não permitida"), false);
    }
  },
  credentials: true,
});

await app.register(swagger, {
  openapi: {
    info: { title: "$project_name API", description: "Documentação", version: "1.0.0" },
    servers: [{ url: API_URL }],
  },
});

await app.register(swaggerUI, { routePrefix: "/docs" });

app.get("/health", async () => ({ status: "ok", timestamp: new Date().toISOString() }));

await app.register(registerRoutes);

const start = async () => {
  try {
    await app.listen({ port: PORT, host: "0.0.0.0" });
    const address = app.server.address();
    const host = typeof address === "string" ? address : \`http://localhost:\${address?.port}\`;

    app.log.info(\`🚀 API rodando em: \${host}\`);
    app.log.info(\`📘 Swagger Docs: \${host}/docs\`);
  } catch (err) {
    app.log.error(err as Error, 'Erro ao iniciar o servidor:');
    process.exit(1);
  }
};

void start();
EOF

# 📄 ESLint 9 (Flat Config)
echo -e "\n📄 Criando ESLint 9 e Prettier..."
cat > eslint.config.mjs <<EOF
import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';
import eslintConfigPrettier from 'eslint-config-prettier';

export default tseslint.config(
  eslint.configs.recommended,
  ...tseslint.configs.recommendedTypeChecked,
  ...tseslint.configs.stylisticTypeChecked,
  eslintConfigPrettier, 
  {
    languageOptions: {
      parserOptions: {
        projectService: true,
        tsconfigRootDir: import.meta.dirname,
      },
    },
    rules: {
      '@typescript-eslint/consistent-type-imports': 'error',
      '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
      '@typescript-eslint/no-explicit-any': 'warn',
      '@typescript-eslint/no-floating-promises': 'off', 
      '@typescript-eslint/no-misused-promises': 'off'
    },
  },
  {
    ignores: ['dist/**', 'node_modules/**', 'eslint.config.mjs', 'prisma.config.ts'],
  }
);
EOF

# 📄 Prettier
cat > .prettierrc <<EOF
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "all",
  "printWidth": 100,
  "arrowParens": "always",
  "plugins": []
}
EOF

# 📄 VS Code Config
mkdir -p .vscode
cat > .vscode/settings.json <<EOF
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "eslint.useFlatConfig": true,
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
EOF

cat > .gitignore <<EOF
node_modules
dist
.env
.eslintcache
.vscode/*
!.vscode/settings.json
!.vscode/extensions.json
EOF

# Gera arquivo ts inicial Prisma
pnpm run db:generate

# -----------------------------------------------------------------------------
# 🧬 INICIALIZAÇÃO GIT + GITHUB CLI (gh)
# -----------------------------------------------------------------------------
echo -e "\n--------------------------------------------------"
echo -e "🐙 Configuração de Controle de Versão (Git/GitHub)"
echo -e "--------------------------------------------------\n"

read -p "Deseja inicializar o repositório Git local e fazer o 1º commit? (y/n): " git_init
if [[ "$git_init" == "y" || "$git_init" == "Y" ]]; then
  
  if ! command -v git &> /dev/null; then
    echo "⚠️  Git não encontrado. Instale-o primeiro."
  else
    git init
    git add .
    git commit -m "feat: initial commit (Fastify, Prisma 7, Docker, ESLint9)"
    git branch -M main
    echo "✅ Repositório local inicializado e commitado!"

    read -p "Deseja criar o repositório no GitHub e fazer o push via GitHub CLI (gh)? (y/n): " gh_push
    if [[ "$gh_push" == "y" || "$gh_push" == "Y" ]]; then
      
      # Verifica se a ferramenta 'gh' está instalada
      if ! command -v gh &> /dev/null; then
        echo "⚠️  GitHub CLI (gh) não instalado. Faça o download em: https://cli.github.com/"
      else
        # Verifica se o usuário está logado
        if ! gh auth status &> /dev/null; then
          echo "⚠️  Você não está autenticado no GitHub CLI."
          echo "Rodando 'gh auth login' para você. Siga os passos na tela:"
          gh auth login
        fi

        # Verifica novamente se logou com sucesso
        if gh auth status &> /dev/null; then
          read -p "O repositório deve ser Público ou Privado? (1=Public, 2=Private): " repo_visibility
          VISIBILITY="--private"
          if [[ "$repo_visibility" == "1" ]]; then
             VISIBILITY="--public"
          fi
          
          echo "🌐 Criando repositório '$project_name' no GitHub e subindo o código..."
          
          # gh repo create <nome> --public/private --source=. --remote=origin --push
          gh repo create "$project_name" $VISIBILITY --source=. --remote=origin --push
          
          echo "✅ Código enviado com sucesso para o GitHub!"
        else
          echo "❌ Falha na autenticação do GitHub CLI. Processo abortado."
        fi
      fi
    fi
  fi
fi

echo -e "\n🎉 Tudo pronto! Projeto '$project_name' montado com sucesso!"
echo -e "👉 Para rodar a aplicação:\n"
echo "1️⃣  cd $project_name"
echo "2️⃣  pnpm run docker:up        # Sobe o banco de dados no Docker"
echo "3️⃣  pnpm run db:migrate       # Aplica as migrations (Cria as tabelas no Postgres)"
echo "4️⃣  pnpm run dev              # Inicia o servidor Fastify"
