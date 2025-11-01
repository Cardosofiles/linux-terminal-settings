#!/bin/bash

clear
echo "🚀 Criador de API Fastify com Docker, TypeScript, PostgreSQL, PgAdmin e Biome"

read -p "📦 Digite o nome do projeto: " project_name

project_name="${project_name//_/-}" 

if [[ ! "$project_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "❌ Nome do projeto inválido. Use apenas letras, números, hífens ou underscores."
  exit 1
fi

mkdir "$project_name"
cd "$project_name" || exit 1

# 🧱 Inicializa projeto Node + TypeScript
echo -e "\n🧱 Inicializando projeto Node.js com TypeScript e Fastify 🔥🚀..."

# Cria package.json com scripts prontos
echo -e "\n📦 Criando package.json com scripts úteis..."
cat > package.json <<EOF
{
  "name": "$project_name",
  "version": "1.0.0",
  "type": "module",
  "main": "dist/server.js",
  "scripts": {
    "dev": "tsx watch src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "check": "tsc --noEmit",
    "lint": "biome lint .",
    "format": "biome format . --write",
    "docker:up": "docker compose up -d",
    "docker:stop": "docker stop ${project_name}-db ${project_name}-pgadmin",
    "docker:down": "docker compose down ${project_name}-db ${project_name}-pgadmin",
    "docker:logs": "docker compose logs -f",
    "db:psql": "docker exec -it ${project_name}-db psql -U postgres",
    "pgadmin": "xdg-open http://localhost:5050"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "description": "",
  "packageManager": "pnpm@10.11.0"
}
EOF

pnpm add fastify @fastify/cors @fastify/helmet @fastify/swagger @fastify/swagger-ui drizzle-orm pg dotenv zod
pnpm add -D typescript tsx @types/node @types/pg @biomejs/biome pino-pretty drizzle-kit drizzle-seed fastify-type-provider-zod
pnpm dlx biome init --yes

# Cria tsconfig.json
cat > tsconfig.json <<EOF
{
  "\$schema": "https://json.schemastore.org/tsconfig",
  "compilerOptions": {
    "target": "ES2022",
    "module": "nodenext",
    "moduleResolution": "nodenext",
    "lib": [
      "ES2022",
      "ESNext.Array",
      "ESNext.Collection",
      "ESNext.AsyncIterable"
    ],
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "resolveJsonModule": true,
    "allowImportingTsExtensions": false,
    "forceConsistentCasingInFileNames": true,
    "skipLibCheck": true,
    "incremental": true,
    "isolatedModules": true,

    // Apenas se você usar decorators (ex: class-validator ou typeorm)
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,

    // Inclui tipagens do Node
    "types": ["node"]
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist"]
}

EOF

# 🌱 Estrutura de diretórios
mkdir -p src/utils src/routes src/services src/test src/modules


# 📄 Cria arquivo de ambiente
echo -e "\n📄 Criando arquivo .env..."
cat > .env <<EOF
# Porta da aplicação Fastify
PORT=3333

# Configurações do banco PostgreSQL (usar credenciais reais)
FASTIFY_DATASOURCE_USERNAME=postgres
FASTIFY_DATASOURCE_PASSWORD=senhaSegura123
POSTGRES_DB=${project_name}_db
DATABASE_URL=postgres://\${FASTIFY_DATASOURCE_USERNAME}:\${FASTIFY_DATASOURCE_PASSWORD}@localhost:5432/\${POSTGRES_DB}

# Credenciais de acesso ao pgAdmin
PGADMIN_DEFAULT_EMAIL=admin@example.com
PGADMIN_DEFAULT_PASSWORD=senhaAdmin123

# URL base da API para Swagger (opcional)
API_URL=http://localhost:3333

# Origens permitidas para CORS (separadas por vírgula)
CORS_ORIGIN=http://localhost:3000,http://meusite.com
EOF

# # 📄 Cria Dockerfile
# cat > Dockerfile <<EOF
# FROM node:20-alpine
# WORKDIR /app
# COPY . .
# RUN corepack enable && corepack prepare pnpm@latest --activate
# RUN pnpm install
# CMD ["pnpm", "dev"]
# EOF

# 📄 Cria docker-compose.yml
echo -e "\n📄 Criando docker-compose.yml para PostgreSQL e PgAdmin..."
cat > docker-compose.yml <<EOF
services:
  db:
    image: postgres
    container_name: ${project_name}-db
    ports:
      - '5432:5432'
    env_file:
      - .env
    environment:
      POSTGRES_USER: \${FASTIFY_DATASOURCE_USERNAME}
      POSTGRES_PASSWORD: \${FASTIFY_DATASOURCE_PASSWORD}
      POSTGRES_DB: \${POSTGRES_DB}
    networks:
      - backend
    volumes:
      - ./docker/setup.sql:/docker-entrypoint-initdb.d/setup.sql
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U \${FASTIFY_DATASOURCE_USERNAME}']
      interval: 10s
      timeout: 5s
      retries: 5

  pgadmin:
    image: dpage/pgadmin4
    container_name: ${project_name}-pgadmin
    ports:
      - '5050:80'
    environment:
      PGADMIN_DEFAULT_EMAIL: \${PGADMIN_DEFAULT_EMAIL}
      PGADMIN_DEFAULT_PASSWORD: \${PGADMIN_DEFAULT_PASSWORD}
    depends_on:
      - db
    volumes:
      - pgadmin-data:/var/lib/pgadmin
      - ./pgadmin/servers.json:/pgadmin4/servers.json
    networks:
      - backend

volumes:
  pgadmin-data: {}
  pgdata: {}

networks:
  backend:
EOF

# 📄 src/utils/env.ts
echo -e "\n📄 Criando src/utils/env.ts para validação de variáveis de ambiente..."
cat > src/utils/env.ts <<EOF
import { z } from "zod";

const envSchema = z.object({
  PORT: z.coerce.number().default(3333),
  DATABASE_URL: z
    .string()
    .url()
    .startsWith("postgres://")
    .default("postgres://localhost:5432/${project_name}_db"),
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

# 📄 src/server.ts
echo -e "\n📄 Criando src/server.ts com configuração inicial..."
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

import { getExample } from "./routes/get-example.js";
import { env } from "./utils/env.js";

const config = env.CORS_ORIGIN;
const PORT = env.PORT || 3333;
const API_URL = env.API_URL || \`http://localhost:\${PORT}\`;

const app = Fastify({
  logger: {
    transport: {
      target: "pino-pretty",
      options: {
        translateTime: "HH:MM:ss Z",
        ignore: "pid,hostname",
        colorize: true,
      },
    },
  },
}).withTypeProvider<ZodTypeProvider>();

app.setSerializerCompiler(serializerCompiler);
app.setValidatorCompiler(validatorCompiler);

app.register(helmet, { contentSecurityPolicy: false });
app.register(cors, {
  origin: (origin, cb) => {
    const allowedOrigins = config?.split(",") || [];
    if (!origin || allowedOrigins.includes(origin)) {
      cb(null, true);
    } else {
      cb(new Error("Origem não permitida"), false);
    }
  },
  credentials: true,
});

app.register(swagger, {
  openapi: {
    info: {
      title: "",
      description: "",
      version: "1.0.0",
    },
    servers: [{ url: API_URL }],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: "http",
          scheme: "bearer",
          bearerFormat: "JWT",
        },
      },
    },
    security: [{ bearerAuth: [] }],
  },
});

app.register(swaggerUI, {
  routePrefix: "/docs",
  uiConfig: {
    docExpansion: "list",
    deepLinking: true,
  },
});

app.get("/health", () => {
  return { status: "ok", timestamp: new Date().toISOString() };
});

app.register(getExample);

const start = async () => {
  try {
    await app.listen({ port: PORT, host: "0.0.0.0" });

    const address = app.server.address();
    const host =
      typeof address === "string"
        ? address
        : \`http://localhost:\${address?.port}\`;

    app.log.info(\`🚀 API rodando em: \${host}\`);
    app.log.info(\`📘 Swagger Docs: \${host}/docs\`);
  } catch (err) {
    app.log.error(err as Error, 'Erro ao iniciar o servidor:');
    process.exit(1);
  }
};

start();
EOF

# 📄 src/routes/get-rooms.ts
cat > src/routes/get-example.ts <<EOF
import type { FastifyPluginAsyncZod } from 'fastify-type-provider-zod'

export const getExample: FastifyPluginAsyncZod = async app => {
  app.get('/hello', async () => {
    return 'Hello, Fastify with TypeScript and PostgreSQL!'
  })
}
EOF

# Cria o arquivo biome.json com configurações ideais
echo -e "\n📄 Criando biome.json com regras recomendadas..."
cat > biome.json <<EOF
{
  "\$schema": "./node_modules/@biomejs/biome/configuration_schema.json",
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
    "rules": {
      "recommended": true,
      "a11y": {
        "noSvgWithoutTitle": "off"
      },
      "suspicious": {
        "noArrayIndexKey": "info"
      }
    }
  }
}
EOF

mkdir -p .vscode
cat > .vscode/settings.json <<EOF
{
  "[javascript]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[typescript]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[json]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[markdown]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[yaml]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "editor.codeActionsOnSave": {
    "source.organizeImports.biome": true
  },
  "editor.formatOnSave": true,
  "prettier.enable": false,
  "biome.enableLinter": true,
  "biome.enableFormatter": true
}
EOF

cat > drizzle.config.ts <<EOF
import { defineConfig } from 'drizzle-kit';
import { env } from './src/utils/env';

export default defineConfig({
  schema: './src/db/schema/**.ts',
  dialect: 'postgresql',
  out: './src/db/migrations',
  dbCredentials: {
    url: env.DATABASE_URL,
  },
  casing: 'snake_case',
});
EOF

cat > .gitignore <<EOF
/node_modules
/dist
/.env
/.vscode
EOF

# 🔧 Ajustes finais de estrutura
mkdir -p docker
touch docker/setup.sql

mkdir -p pgadmin
cat > pgadmin/servers.json <<EOF
{
  "Servers": {
    "1": {
      "Name": "PostgreSQL Local",
      "Group": "Servers",
      "Host": "db",
      "Port": 5432,
      "MaintenanceDB": "postgres",
      "Username": "postgres",
      "SSLMode": "prefer"
    }
  }
}
EOF

mkdir -p src/db/schema

# 🧬 Inicializa Git + GitHub
read -p "🔗 Deseja criar repositório Git local? (y/n): " git_init
if [[ "$git_init" == "y" ]]; then
  git init
  git add .
  git commit -m "🧱 initial commit"

  read -p "🌐 Deseja criar um repositório no GitHub e fazer push? (y/n): " gh_push
  if [[ "$gh_push" == "y" ]]; then
    read -p "🔐 Qual o nome do repositório no GitHub (ou ENTER para '$project_name')? " repo_name
    repo_name=${repo_name:-$project_name}

    gh repo create "$repo_name" --public --source=. --remote=origin --push
    echo "✅ Repositório enviado para o GitHub!"
  fi
fi

# read -p "🐳 Deseja iniciar os containers com Docker Compose agora? (y/n): " run_docker
# if [[ "$run_docker" == "y" ]]; then
#   cd "$project_name"
#   docker-compose up -d
#   echo "✅ Containers iniciados com sucesso!"
# fi


echo -e "\n✅ Projeto '$project_name' criado com sucesso!"
echo -e "👉 Para rodar o projeto:\n"
echo "Acesse o projeto cd '$project_name'"
echo "1️⃣ docker-compose up -d"
echo "2️⃣ pnpm dev (após configurar script no package.json)"
echo "3️⃣ crie os scripts abaixo no package.json para iniciar o servidor"
