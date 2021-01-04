import 'package:firebase_auth/firebase_auth.dart';
import 'package:me_compre/data/models/item_model.dart';
import 'package:me_compre/data/providers/firebase_auth_provider.dart';

class CadastroRepository {
  final _provider = FirebaseAuthProvider();

  Future<UsuarioModel> cadastrarUsuario(
      String email, String senha, String nome, String fotoURL) async {
    var usuario;

    
      var map = await _provider.createUserWithEmailAndPassword(
          email: email, senha: senha, nome: nome, fotoURL: fotoURL);

      if (map != null) {
        usuario = new UsuarioModel.fromMap(map);
      }

      return usuario;
    
  }
}
