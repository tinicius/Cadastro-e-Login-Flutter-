class UsuarioModel {
  String id;
  String nome;
  String email;
  String senha;
  String sexo;
  String foto;

  UsuarioModel(
      {this.id, this.nome, this.email, this.senha, this.sexo, this.foto});

  UsuarioModel.fromMap(Map map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.email = map['email'];
    this.senha = map['senha'];
    this.sexo = map['sexo'];
    this.foto = map['foto'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'nome': this.nome,
      'email': this.email,
      'senha': this.senha,
      'sexo': this.sexo,
      'foto': this.foto
    };

    return map;
  }
}
