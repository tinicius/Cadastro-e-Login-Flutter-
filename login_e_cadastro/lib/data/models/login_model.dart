class LoginModel {
  String id;
  String email;
  String senha;

  LoginModel({this.id, this.email, this.senha});

  LoginModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    //this.senha = map['senha'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'email': this.email,
      //'senha': this.senha
    };

    return map;
  }
}
