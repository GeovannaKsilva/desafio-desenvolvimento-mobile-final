// Modelo que representa um Cliente no sistema
class Cliente {
  final int? id;
  final String nome;
  final String sobrenome;
  final String email;
  final int idade;
  final String? foto;

  Cliente({
    this.id,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.idade,
    this.foto,
  });

  // Converte JSON do backend para objeto Cliente
  factory Cliente.fromJson(Map<String, dynamic> json) {
    int idadeValue;
    if (json['idade'] is String) {
      idadeValue = int.parse(json['idade']);
    } else {
      idadeValue = json['idade'] as int;
    }

    return Cliente(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      sobrenome: json['sobrenome'] as String,
      email: json['email'] as String,
      idade: idadeValue,
      foto: json['foto'] as String?,
    );
  }

  // Converte objeto Cliente para JSON para enviar ao backend
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'idade': idade,
      'foto': foto,
    };
  }
}