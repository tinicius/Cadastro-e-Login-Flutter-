class UsuarioModel {
  String id;
  String nome;
  String foto;
  int unidades;
  double valor;

  UsuarioModel({this.id, this.nome, this.foto, this.unidades, this.valor});

  UsuarioModel.fromMap(Map map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.foto = map['foto'];
    this.unidades = map['unidades'];
    this.valor = map['valor'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'nome': this.nome,
      'foto': this.foto,
      'unidades': this.unidades,
      'valor': this.valor
    };

    return map;
  }
}
