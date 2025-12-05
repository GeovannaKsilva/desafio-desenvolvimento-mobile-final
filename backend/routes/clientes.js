const express = require('express');
const router = express.Router();
const { db } = require('../database/init');

router.get('/', (req, res) => {
  db.all('SELECT * FROM clientes', [], (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

router.get('/:id', (req, res) => {
  db.get('SELECT * FROM clientes WHERE id = ?', [req.params.id], (err, row) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    if (!row) {
      return res.status(404).json({ error: 'Cliente não encontrado' });
    }
    res.json(row);
  });
});

router.post('/', (req, res) => {
  const { nome, sobrenome, email, idade, foto } = req.body;
  
  if (!nome || !sobrenome || !email || !idade) {
    return res.status(400).json({ error: 'Todos os campos são obrigatórios' });
  }

  db.run(
    'INSERT INTO clientes (nome, sobrenome, email, idade, foto) VALUES (?, ?, ?, ?, ?)',
    [nome, sobrenome, email, idade, foto],
    function(err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.status(201).json({ id: this.lastID, nome, sobrenome, email, idade, foto });
    }
  );
});

router.put('/:id', (req, res) => {
  const { nome, sobrenome, email, idade, foto } = req.body;
  
  db.run(
    'UPDATE clientes SET nome = ?, sobrenome = ?, email = ?, idade = ?, foto = ? WHERE id = ?',
    [nome, sobrenome, email, idade, foto, req.params.id],
    function(err) {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      if (this.changes === 0) {
        return res.status(404).json({ error: 'Cliente não encontrado' });
      }
      res.json({ id: Number(req.params.id), nome, sobrenome, email, idade, foto });
    }
  );
});

router.delete('/:id', (req, res) => {
  db.run('DELETE FROM clientes WHERE id = ?', [req.params.id], function(err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    if (this.changes === 0) {
      return res.status(404).json({ error: 'Cliente não encontrado' });
    }
    res.json({ message: 'Cliente deletado com sucesso' });
  });
});

module.exports = router;