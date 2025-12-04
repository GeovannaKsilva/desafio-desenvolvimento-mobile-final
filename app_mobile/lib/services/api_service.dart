import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cliente.dart';
import '../models/produto.dart';

// Serviço responsável pela comunicação com o backend
class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  // Busca todos os clientes
  Future<List<Cliente>> getClientes() async {
    final response = await http.get(Uri.parse('$baseUrl/clientes'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Cliente.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar clientes');
    }
  }

  // Cria um novo cliente
  Future<Cliente> createCliente(Cliente cliente) async {
    final response = await http.post(
      Uri.parse('$baseUrl/clientes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente.toJson()),
    );
    if (response.statusCode == 201) {
      return Cliente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao criar cliente');
    }
  }

  // Atualiza um cliente existente
  Future<Cliente> updateCliente(int id, Cliente cliente) async {
    final response = await http.put(
      Uri.parse('$baseUrl/clientes/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente.toJson()),
    );
    if (response.statusCode == 200) {
      return Cliente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao atualizar cliente');
    }
  }

  // Deleta um cliente
  Future<void> deleteCliente(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/clientes/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar cliente');
    }
  }

  // Busca todos os produtos
  Future<List<Produto>> getProdutos() async {
    final response = await http.get(Uri.parse('$baseUrl/produtos'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Produto.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar produtos');
    }
  }

  // Cria um novo produto
  Future<Produto> createProduto(Produto produto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/produtos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto.toJson()),
    );
    if (response.statusCode == 201) {
      return Produto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao criar produto');
    }
  }

  // Atualiza um produto existente
  Future<Produto> updateProduto(int id, Produto produto) async {
    final response = await http.put(
      Uri.parse('$baseUrl/produtos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(produto.toJson()),
    );
    if (response.statusCode == 200) {
      return Produto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao atualizar produto');
    }
  }

  // Deleta um produto
  Future<void> deleteProduto(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/produtos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar produto');
    }
  }
}