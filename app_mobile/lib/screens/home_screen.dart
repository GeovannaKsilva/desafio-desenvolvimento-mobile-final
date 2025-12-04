import 'package:flutter/material.dart';
import 'clientes_screen.dart';
import 'produtos_screen.dart';

// Tela inicial com opções para navegar entre Clientes e Produtos
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Gestão'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.business, size: 100, color: Colors.blue),
            const SizedBox(height: 40),
            const Text(
              'Bem-vindo ao Sistema',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Escolha uma opção para gerenciar',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 60),
            
            // Botão para navegar para Clientes
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientesScreen()),
                );
              },
              icon: const Icon(Icons.people, size: 30),
              label: const Text('Gerenciar Clientes', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                minimumSize: const Size(280, 60),
              ),
            ),
            const SizedBox(height: 20),
            
            // Botão para navegar para Produtos
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProdutosScreen()),
                );
              },
              icon: const Icon(Icons.inventory, size: 30),
              label: const Text('Gerenciar Produtos', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                minimumSize: const Size(280, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}