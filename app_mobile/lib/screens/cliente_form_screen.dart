import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../services/api_service.dart';

// Formulário para criar ou editar um cliente
class ClienteFormScreen extends StatefulWidget {
  final Cliente? cliente;

  const ClienteFormScreen({super.key, this.cliente});

  @override
  State<ClienteFormScreen> createState() => _ClienteFormScreenState();
}

class _ClienteFormScreenState extends State<ClienteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  late TextEditingController _nomeController;
  late TextEditingController _sobrenomeController;
  late TextEditingController _emailController;
  late TextEditingController _idadeController;
  late TextEditingController _fotoController;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.cliente?.nome ?? '');
    _sobrenomeController = TextEditingController(text: widget.cliente?.sobrenome ?? '');
    _emailController = TextEditingController(text: widget.cliente?.email ?? '');
    _idadeController = TextEditingController(text: widget.cliente?.idade.toString() ?? '');
    _fotoController = TextEditingController(text: widget.cliente?.foto ?? '');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _emailController.dispose();
    _idadeController.dispose();
    _fotoController.dispose();
    super.dispose();
  }

  // Salva ou atualiza o cliente
  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final idadeValue = int.tryParse(_idadeController.text);
      if (idadeValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Idade inválida')),
        );
        setState(() => _loading = false);
        return;
      }

      final cliente = Cliente(
        id: widget.cliente?.id,
        nome: _nomeController.text,
        sobrenome: _sobrenomeController.text,
        email: _emailController.text,
        idade: idadeValue,
        foto: _fotoController.text.isEmpty ? null : _fotoController.text,
      );

      try {
        if (widget.cliente == null) {
          await _apiService.createCliente(cliente);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cliente criado com sucesso')),
          );
        } else {
          await _apiService.updateCliente(widget.cliente!.id!, cliente);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cliente atualizado com sucesso')),
          );
        }
        Navigator.pop(context);
      } catch (e) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cliente == null ? 'Novo Cliente' : 'Editar Cliente'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo Nome
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome';
                        }
                        if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value)) {
                          return 'Nome deve conter apenas letras';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo Sobrenome
                    TextFormField(
                      controller: _sobrenomeController,
                      decoration: const InputDecoration(
                        labelText: 'Sobrenome',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o sobrenome';
                        }
                        if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(value)) {
                          return 'Sobrenome deve conter apenas letras';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo Email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o email';
                        }
                        if (!value.contains('@')) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo Idade
                    TextFormField(
                      controller: _idadeController,
                      decoration: const InputDecoration(
                        labelText: 'Idade',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.cake),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a idade';
                        }
                        final idade = int.tryParse(value);
                        if (idade == null || idade <= 0) {
                          return 'Idade inválida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Campo Foto (URL)
                    TextFormField(
                      controller: _fotoController,
                      decoration: const InputDecoration(
                        labelText: 'URL da Foto (opcional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.image),
                        hintText: 'https://exemplo.com/foto.jpg',
                      ),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 32),

                    // Botão Salvar
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _salvar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Salvar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}