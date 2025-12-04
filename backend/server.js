const express = require('express');
const cors = require('cors');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const clientesRoutes = require('./routes/clientes');
const produtosRoutes = require('./routes/produtos');
const { initDatabase } = require('./database/init');

const app = express();
const PORT = 3000;

// Criar pasta uploads se não existir
const uploadsDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir);
}

// Middlewares
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads'));

// Configuração do multer para upload de fotos
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + '-' + Math.round(Math.random() * 1E9) + path.extname(file.originalname);
    cb(null, uniqueName);
  }
});

const upload = multer({ storage });

// Rotas
app.use('/api/clientes', clientesRoutes);
app.use('/api/produtos', produtosRoutes);

// Rota de upload de foto
app.post('/api/upload', upload.single('foto'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'Nenhum arquivo enviado' });
  }
  const fotoUrl = `http://localhost:${PORT}/uploads/${req.file.filename}`;
  res.json({ foto: fotoUrl });
});

// Rota inicial
app.get('/', (req, res) => {
  res.json({ message: 'API funcionando! Use /api/clientes ou /api/produtos' });
});

// Inicializar banco de dados e iniciar servidor
initDatabase().then(() => {
  app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
  });
});