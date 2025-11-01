# fastify-postgresql-script.sh

## Descrição

Script completo e automatizado para criar uma API REST moderna com Fastify, TypeScript, PostgreSQL, PgAdmin e Docker, incluindo todas as configurações e dependências necessárias.

## Funcionalidade

### 1. Criação do Projeto

- Solicita o nome do projeto
- Valida o nome (apenas letras, números, hífens e underscores)
- Cria estrutura de diretórios completa

### 2. Configuração Node.js/TypeScript

- Cria `package.json` com scripts úteis
- Instala dependências de produção:

  - `fastify` - Framework web
  - `@fastify/cors` - Suporte CORS
  - `@fastify/helmet` - Segurança HTTP
  - `@fastify/swagger` - Documentação OpenAPI
  - `@fastify/swagger-ui` - Interface Swagger
  - `drizzle-orm` - ORM para PostgreSQL
  - `pg` - Driver PostgreSQL
  - `dotenv` - Variáveis de ambiente
  - `zod` - Validação de schemas

- Instala dependências de desenvolvimento:
  - `typescript` - Compilador TypeScript
  - `tsx` - Execução TypeScript
  - `@biomejs/biome` - Linter e formatter
  - `drizzle-kit` - CLI Drizzle ORM
  - `fastify-type-provider-zod` - Type safety com Zod
  - `pino-pretty` - Logger formatado

### 3. Estrutura de Pastas

```
project-name/
├── src/
│   ├── utils/          # Utilitários (validação env)
│   ├── routes/         # Rotas da API
│   ├── services/       # Lógica de negócio
│   ├── modules/        # Módulos da aplicação
│   ├── test/           # Testes
│   └── db/
│       └── schema/     # Schemas Drizzle
├── docker/
│   └── setup.sql       # Scripts SQL iniciais
├── pgadmin/
│   └── servers.json    # Configuração PgAdmin
└── .vscode/
    └── settings.json   # Configurações VSCode
```

### 4. Configuração Docker

- **PostgreSQL**: Banco de dados principal
- **PgAdmin**: Interface web para gerenciar PostgreSQL
- Volumes persistentes para dados
- Health checks configurados
- Network isolada para segurança

### 5. Arquivos de Configuração

#### `.env`

```env
PORT=3333
DATABASE_URL=postgres://user:password@localhost:5432/database
POSTGRES_DB=nome_do_banco
FASTIFY_DATASOURCE_USERNAME=postgres
FASTIFY_DATASOURCE_PASSWORD=senhaSegura123
PGADMIN_DEFAULT_EMAIL=admin@example.com
PGADMIN_DEFAULT_PASSWORD=senhaAdmin123
CORS_ORIGIN=http://localhost:3000
API_URL=http://localhost:3333
```

#### `tsconfig.json`

- Target ES2022
- Module NodeNext
- Strict mode ativado
- Suporte a decorators

#### `biome.json`

- Formatação com 2 espaços
- Single quotes
- Trailing commas ES5
- Linter habilitado

#### `drizzle.config.ts`

- Configuração do Drizzle ORM
- Dialeto PostgreSQL
- Snake case para colunas

### 6. Servidor Fastify

Cria `src/server.ts` com:

- Type-safe routing com Zod
- CORS configurado
- Helmet para segurança
- Swagger/OpenAPI docs em `/docs`
- Health check em `/health`
- Logger Pino com formatação
- Validação de variáveis de ambiente

### 7. Integração Git/GitHub (Opcional)

- Inicialização de repositório Git
- Commit inicial
- Criação de repositório no GitHub
- Push automático

## Como Usar

### Executar o script

```bash
./src/fastify-postgresql-script.sh
```

ou

```bash
bash src/fastify-postgresql-script.sh
```

### Passo a passo interativo

1. **Nome do projeto**

   ```
   📦 Digite o nome do projeto: minha-api
   ```

2. **Inicialização Git** (opcional)

   ```
   🔗 Deseja criar repositório Git local? (y/n): y
   ```

3. **GitHub** (opcional)
   ```
   🌐 Deseja criar um repositório no GitHub e fazer push? (y/n): y
   🔐 Qual o nome do repositório no GitHub (ou ENTER para 'minha-api')?
   ```

## Comandos Disponíveis

### Desenvolvimento

```bash
pnpm dev              # Inicia servidor em modo watch
pnpm build            # Compila TypeScript
pnpm start            # Inicia servidor em produção
pnpm check            # Verifica tipos TypeScript
```

### Code Quality

```bash
pnpm lint             # Executa linter Biome
pnpm format           # Formata código com Biome
```

### Docker

```bash
pnpm docker:up        # Inicia containers
pnpm docker:stop      # Para containers
pnpm docker:down      # Remove containers
pnpm docker:logs      # Visualiza logs
```

### Banco de Dados

```bash
pnpm db:psql          # Acessa psql no container
pnpm pgadmin          # Abre PgAdmin no navegador
```

## Acessos

### API Fastify

- **URL**: http://localhost:3333
- **Health**: http://localhost:3333/health
- **Docs**: http://localhost:3333/docs

### PgAdmin

- **URL**: http://localhost:5050
- **Email**: admin@example.com
- **Senha**: senhaAdmin123

### PostgreSQL

- **Host**: localhost
- **Port**: 5432
- **User**: postgres
- **Password**: senhaSegura123
- **Database**: nome-do-projeto_db

## Requisitos

- Node.js 20+ (instalado via fnm/nvm)
- pnpm (gerenciador de pacotes)
- Docker e Docker Compose
- Git (para integração GitHub)
- GitHub CLI (`gh`) - opcional, para criar repo automaticamente

## Próximos Passos

Após executar o script:

1. **Iniciar containers**

   ```bash
   cd nome-do-projeto
   pnpm docker:up
   ```

2. **Criar schema do banco**

   ```typescript
   // src/db/schema/users.ts
   import { pgTable, serial, text, timestamp } from "drizzle-orm/pg-core";

   export const users = pgTable("users", {
     id: serial("id").primaryKey(),
     name: text("name").notNull(),
     email: text("email").notNull().unique(),
     createdAt: timestamp("created_at").defaultNow(),
   });
   ```

3. **Gerar migrations**

   ```bash
   pnpm drizzle-kit generate
   pnpm drizzle-kit migrate
   ```

4. **Iniciar desenvolvimento**
   ```bash
   pnpm dev
   ```

## Observações

- O script usa `pnpm` como gerenciador de pacotes
- Biome substitui ESLint + Prettier
- Drizzle ORM oferece type-safety completo
- Swagger UI disponível automaticamente
- PgAdmin pré-configurado com conexão ao PostgreSQL
