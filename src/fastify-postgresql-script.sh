#!/bin/bash

clear
echo "🚀 Criador de API Fastify com Clean Architecture, DDD, Prisma 7, Docker, e ESLint 9"

read -p "📦 Digite o nome do projeto: " project_name
project_name="${project_name//_/-}" 

if [[ ! "$project_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "❌ Nome do projeto inválido. Use apenas letras, números, hífens ou underscores."
  exit 1
fi

mkdir "$project_name"
cd "$project_name" || exit 1

# 🧱 Inicializa projeto Node
echo -e "\n🧱 Inicializando projeto Node.js com TypeScript 🔥🚀..."

cat > package.json <<EOF
{
  "name": "$project_name",
  "version": "1.0.0",
  "type": "module",
  "main": "dist/infra/http/server.js",
  "scripts": {
    "dev": "tsx watch src/infra/http/server.ts",
    "build": "tsc && tsc-alias",
    "start": "node dist/infra/http/server.js",
    "check": "tsc --noEmit",
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "format": "prettier --write \"src/**/*.ts\"",
    "db:generate": "prisma generate",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio",
    "docker:up": "docker compose up -d",
    "docker:stop": "docker compose stop",
    "docker:down": "docker compose down"
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

# 🌱 ESTRUTURA CLEAN ARCHITECTURE E DDD
echo -e "\n🌱 Criando estrutura de pastas (Domain, Application, Infra)..."
mkdir -p src/domain/examples/entities
mkdir -p src/domain/examples/repositories
mkdir -p src/application/examples/use-cases
mkdir -p src/infra/http/controllers/examples
mkdir -p src/infra/http/routes
mkdir -p src/infra/database/prisma/repositories
mkdir -p src/infra/env
mkdir -p prisma

# 📄 Cria arquivo de ambiente (.env)
cat > .env <<EOF
PORT=3333
NODE_ENV=development

POSTGRES_USER=postgres
POSTGRES_PASSWORD=senhaSegura123
POSTGRES_DB=${project_name}_db
DATABASE_URL="postgresql://postgres:senhaSegura123@localhost:5432/${project_name}_db?schema=public"

API_URL=http://localhost:3333
CORS_ORIGIN=http://localhost:3000,http://localhost:3333
EOF

# 📄 Prisma Schema
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

  @@map("examples")
}
EOF

# 📄 Prisma Config 7
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

# 📄 Docker Compose
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
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "\${POSTGRES_USER}", "-d", "\${POSTGRES_DB}"]
      interval: 2s
      timeout: 2s
      retries: 10
      start_period: 5s
volumes:
  pgdata:
    driver: local
EOF

# ---------------------------------------------------------
# CÓDIGO FONTE (Aplicando as Camadas)
# ---------------------------------------------------------

# 1. ENV (Infra)
cat > src/infra/env/index.ts <<EOF
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
  console.error("❌ Invalid environment variables", result.error.format());
  process.exit(1);
}
export const env = result.data;
EOF

# 2. PRISMA CLIENT (Infra)
cat > src/infra/database/prisma/index.ts <<EOF
import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import { Pool } from 'pg';
import { env } from '@/infra/env/index.js';

const connectionString = env.DATABASE_URL;
const pool = new Pool({ connectionString });
const adapter = new PrismaPg(pool);

export const prisma = new PrismaClient({
  adapter,
  log: env.NODE_ENV === 'development' ? ['query', 'error'] : ['error'],
});
EOF

# 3. ENTITY (Domain - Regras de negócio puras)
cat > src/domain/examples/entities/example.ts <<EOF
export interface ExampleProps {
  id: string;
  name: string;
  createdAt: Date;
}

// Entidade de Domínio - Não tem dependência do banco de dados
export class Example {
  private props: ExampleProps;

  constructor(props: ExampleProps) {
    this.props = props;
  }

  get id() { return this.props.id; }
  get name() { return this.props.name; }
  get createdAt() { return this.props.createdAt; }
}
EOF

# 4. REPOSITORY INTERFACE (Domain - O Contrato que a Infra deve cumprir)
cat > src/domain/examples/repositories/examples-repository.ts <<EOF
import type { Example } from '../entities/example.js';

export interface ExamplesRepository {
  create(data: { name: string }): Promise<Example>;
  countAll(): Promise<number>;
}
EOF

# 5. USE CASE (Application - Orquestração do Negócio)
cat > src/application/examples/use-cases/create-example-use-case.ts <<EOF
import type { ExamplesRepository } from '@/domain/examples/repositories/examples-repository.js';
import type { Example } from '@/domain/examples/entities/example.js';

// Inversão de Dependência (SOLID): Recebemos o contrato, não a implementação
export class CreateExampleUseCase {
  constructor(private examplesRepository: ExamplesRepository) {}

  async execute(name: string): Promise<Example> {
    if (name.length < 3) {
      throw new Error('Name must have at least 3 characters.');
    }
    
    // Regra de negócio orquestrada chamando o repositório
    const example = await this.examplesRepository.create({ name });
    return example;
  }
}
EOF

# 6. PRISMA REPOSITORY (Infra/Database - A Implementação real do Contrato)
cat > src/infra/database/prisma/repositories/prisma-examples-repository.ts <<EOF
import { prisma } from '../index.js';
import type { ExamplesRepository } from '@/domain/examples/repositories/examples-repository.js';
import { Example } from '@/domain/examples/entities/example.js';

export class PrismaExamplesRepository implements ExamplesRepository {
  async create(data: { name: string }): Promise<Example> {
    const rawExample = await prisma.example.create({
      data: { name: data.name },
    });

    // Mapeando a saída do Prisma para a nossa Entidade de Domínio Pura
    return new Example({
      id: rawExample.id,
      name: rawExample.name,
      createdAt: rawExample.createdAt,
    });
  }

  async countAll(): Promise<number> {
    return prisma.example.count();
  }
}
EOF

# 7. CONTROLLER (Infra/Http - Lidando com Requisições web)
cat > src/infra/http/controllers/examples/create-example.controller.ts <<EOF
import type { FastifyRequest, FastifyReply } from 'fastify';
import { z } from 'zod';
import { PrismaExamplesRepository } from '@/infra/database/prisma/repositories/prisma-examples-repository.js';
import { CreateExampleUseCase } from '@/application/examples/use-cases/create-example-use-case.js';

export async function createExampleController(request: FastifyRequest, reply: FastifyReply) {
  const createSchema = z.object({
    name: z.string().min(3),
  });

  const { name } = createSchema.parse(request.body);

  // Injeção de Dependência Manual (Factory Pattern)
  const repository = new PrismaExamplesRepository();
  const useCase = new CreateExampleUseCase(repository);

  try {
    const example = await useCase.execute(name);
    return reply.status(201).send({ example });
  } catch (error) {
    if (error instanceof Error) {
      return reply.status(400).send({ message: error.message });
    }
    throw error;
  }
}
EOF

# 8. ROTAS (Infra/Http)
cat > src/infra/http/routes/examples.routes.ts <<EOF
import type { FastifyInstance } from 'fastify';
import type { FastifyPluginAsyncZod } from 'fastify-type-provider-zod';
import { createExampleController } from '../controllers/examples/create-example.controller.js';
import { PrismaExamplesRepository } from '@/infra/database/prisma/repositories/prisma-examples-repository.js';

export const examplesRoutes: FastifyPluginAsyncZod = async (app: FastifyInstance) => {
  app.post('/examples', createExampleController);

  // Rota simples apenas para contar, usando direto o repositório para query básica
  app.get('/examples/count', async () => {
    const repo = new PrismaExamplesRepository();
    const count = await repo.countAll();
    return { count };
  });
};
EOF

# 9. SERVER (Infra/Http)
cat > src/infra/http/server.ts <<EOF
import cors from "@fastify/cors";
import helmet from "@fastify/helmet";
import Fastify from "fastify";
import { serializerCompiler, validatorCompiler, type ZodTypeProvider } from "fastify-type-provider-zod";
import { env } from "@/infra/env/index.js";
import { examplesRoutes } from "./routes/examples.routes.js";

const app = Fastify({ logger: true }).withTypeProvider<ZodTypeProvider>();

app.setSerializerCompiler(serializerCompiler);
app.setValidatorCompiler(validatorCompiler);

await app.register(helmet, { contentSecurityPolicy: false });
await app.register(cors, { origin: true });

app.get("/health", async () => ({ status: "ok", timestamp: new Date().toISOString() }));

// Registro centralizado de rotas
await app.register(examplesRoutes, { prefix: '/api' });

const start = async () => {
  try {
    await app.listen({ port: env.PORT, host: "0.0.0.0" });
    app.log.info(\`🚀 API rodando na porta \${env.PORT}\`);
  } catch (err) {
    app.log.error(err);
    process.exit(1);
  }
};

void start();
EOF

# 📄 ESLint e Prettier
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
      parserOptions: { projectService: true, tsconfigRootDir: import.meta.dirname },
    },
    rules: {
      '@typescript-eslint/consistent-type-imports': 'error',
      '@typescript-eslint/no-unused-vars': ['warn', { argsIgnorePattern: '^_' }],
      '@typescript-eslint/no-floating-promises': 'off', 
      '@typescript-eslint/no-misused-promises': 'off'
    },
  },
  { ignores: ['dist/**', 'node_modules/**', 'eslint.config.mjs', 'prisma.config.ts'] }
);
EOF

cat > .prettierrc <<EOF
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "all",
  "printWidth": 100,
  "arrowParens": "always"
}
EOF

# 📄 Arquivos de Suporte
mkdir -p .vscode
cat > .vscode/settings.json <<EOF
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": { "source.fixAll.eslint": "explicit" },
  "eslint.useFlatConfig": true,
  "[typescript]": { "editor.defaultFormatter": "esbenp.prettier-vscode" }
}
EOF

cat > .gitignore <<EOF
node_modules
dist
.env
.eslintcache
.vscode/*
!.vscode/settings.json
EOF

# Prisma Generate
pnpm run db:generate

# -----------------------------------------------------------------------------
# 🧬 INICIALIZAÇÃO GIT + GITHUB CLI (gh)
# -----------------------------------------------------------------------------
echo -e "\n--------------------------------------------------"
echo -e "🐙 Configuração de Controle de Versão (Git/GitHub)"
echo -e "--------------------------------------------------\n"

read -p "Deseja inicializar o repositório Git e Github? (y/n): " git_init
if [[ "$git_init" == "y" || "$git_init" == "Y" ]]; then
  git init
  git add .
  git commit -m "feat: setup DDD and Clean Architecture (Fastify/Prisma 7)"
  git branch -M main
  echo "✅ Commit realizado!"

  if command -v gh &> /dev/null; then
    gh repo create "$project_name" --private --source=. --remote=origin --push
    echo "✅ Código enviado para o GitHub!"
  fi
fi

echo -e "\n🎉 Arquitetura DDD e Clean Arch montada com sucesso!"
