const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const dbPath = path.join(__dirname, 'database.db');
const db = new sqlite3.Database(dbPath);

function initDatabase() {
  return new Promise((resolve, reject) => {
    db.serialize(() => {
      db.run(`
        CREATE TABLE IF NOT EXISTS clientes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          sobrenome TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          idade INTEGER NOT NULL,
          foto TEXT
        )
      `);

      db.run(`
        CREATE TABLE IF NOT EXISTS produtos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          descricao TEXT,
          preco REAL NOT NULL,
          data_atualizado DATETIME DEFAULT CURRENT_TIMESTAMP
        )
      `);

      db.run(`DELETE FROM clientes`);
      db.run(`DELETE FROM produtos`);

      const clientes = [
        ['João', 'Silva', 'joao.silva@email.com', 25, null],
        ['Maria', 'Santos', 'maria.santos@email.com', 30, null],
        ['Pedro', 'Oliveira', 'pedro.oliveira@email.com', 28, null]
      ];

      const stmtCliente = db.prepare('INSERT INTO clientes (nome, sobrenome, email, idade, foto) VALUES (?, ?, ?, ?, ?)');
      clientes.forEach(cliente => stmtCliente.run(cliente));
      stmtCliente.finalize();

      const produtos = [
        ['Notebook Dell', 'Notebook com 16GB RAM e SSD 512GB', 3500.00],
        ['Mouse Logitech', 'Mouse sem fio ergonômico', 150.00],
        ['Teclado Mecânico', 'Teclado mecânico RGB', 450.00]
      ];

      const stmtProduto = db.prepare('INSERT INTO produtos (nome, descricao, preco) VALUES (?, ?, ?)');
      produtos.forEach(produto => stmtProduto.run(produto));
      stmtProduto.finalize(() => {
        console.log('Banco de dados inicializado com dados de exemplo');
        resolve();
      });
    });
  });
}

module.exports = { db, initDatabase };