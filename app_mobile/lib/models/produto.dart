// Modelo que representa um Produto no sistema
class Produto {
  final int? id;
  final String nome;
  final String? descricao;
  final double preco;
  final String? dataAtualizado;

  Produto({
    this.id,
    required this.nome,
    this.descricao,
    required this.preco,
    this.dataAtualizado,
  });

  // Converte JSON do backend para objeto Produto
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      preco: json['preco'].toDouble(),
      dataAtualizado: json['data_atualizado'],
    );
  }

  // Converte objeto Produto para JSON para enviar ao backend
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
    };
  }
}