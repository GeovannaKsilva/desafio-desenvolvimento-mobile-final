# Sistema de Gestão - Desafio Final

Sistema completo de gerenciamento de clientes e produtos desenvolvido com Flutter e Node.js.

## Integrantes do Grupo

- Geovanna Karin Silva Gabriel
- Rodrigo Augusto de Melo

## Tecnologias Utilizadas

- **Frontend:** Flutter 3.35.7
- **Backend:** Node.js com Express
- **Banco de Dados:** SQLite

## Estrutura do Projeto
```
desafio_mobile/
├── backend/           # Servidor Node.js
│   ├── database/      # Configuração do banco de dados
│   ├── routes/        # Rotas da API
│   └── server.js      # Arquivo principal do servidor
└── app_mobile/        # Aplicação Flutter
    └── lib/
        ├── models/    # Modelos de dados
        ├── services/  # Serviços de API
        └── screens/   # Telas do aplicativo
```

## Como Executar o Projeto

### 1. Pré-requisitos

- Node.js instalado
- Flutter instalado
- Navegador Chrome (para executar o app)

### 2. Executar o Backend

Abra um terminal e execute:
```bash
cd backend
npm install
node server.js
```

O servidor iniciará em `http://localhost:3000`

### 3. Executar o App Flutter

Abra outro terminal e execute:
```bash
cd app_mobile
flutter pub get
flutter run -d chrome
```

O aplicativo abrirá no navegador Chrome.

## Funcionalidades

### Clientes
- Listar todos os clientes
- Adicionar novo cliente (nome, sobrenome, email, idade)
- Editar cliente existente
- Deletar cliente

### Produtos
- Listar todos os produtos
- Adicionar novo produto (nome, descrição, preço)
- Editar produto existente
- Deletar produto

## API Endpoints

### Clientes
- `GET /api/clientes` - Lista todos os clientes
- `POST /api/clientes` - Cria novo cliente
- `PUT /api/clientes/:id` - Atualiza cliente
- `DELETE /api/clientes/:id` - Deleta cliente

### Produtos
- `GET /api/produtos` - Lista todos os produtos
- `POST /api/produtos` - Cria novo produto
- `PUT /api/produtos/:id` - Atualiza produto
- `DELETE /api/produtos/:id` - Deleta produto

## Banco de Dados

O banco de dados SQLite é criado automaticamente ao iniciar o servidor, com dados de exemplo já populados.