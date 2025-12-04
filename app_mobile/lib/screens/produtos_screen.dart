import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/api_service.dart';
import 'produto_form_screen.dart';

// Tela que lista todos os produtos cadastrados
class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});

  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  final ApiService _apiService = ApiService();
  List<Produto> _produtos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  // Carrega a lista de produtos do backend
  Future<void> _carregarProdutos() async {
    setState(() => _loading = true);
    try {
      final produtos = await _apiService.getProdutos();
      setState(() {
        _produtos = produtos;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar produtos: $e')),
      );
    }
  }

  // Deleta um produto após confirmação
  Future<void> _deletarProduto(int id) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir este produto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      try {
        await _apiService.deleteProduto(id);
        _carregarProdutos();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto excluído com sucesso')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _produtos.isEmpty
              ? const Center(
                  child: Text('Nenhum produto cadastrado',
                      style: TextStyle(fontSize: 18)))
              : ListView.builder(
                  itemCount: _produtos.length,
                  itemBuilder: (context, index) {
                    final produto = _produtos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.inventory, color: Colors.white),
                        ),
                        title: Text(produto.nome),
                        subtitle: Text(
                          '${produto.descricao ?? "Sem descrição"}\nR\$ ${produto.preco.toStringAsFixed(2)}',
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Botão para editar produto
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProdutoFormScreen(produto: produto),
                                  ),
                                );
                                _carregarProdutos();
                              },
                            ),
                            // Botão para deletar produto
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deletarProduto(produto.id!),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      // Botão flutuante para adicionar novo produto
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProdutoFormScreen()),
          );
          _carregarProdutos();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}