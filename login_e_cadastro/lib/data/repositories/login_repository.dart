import 'package:me_compre/data/models/login_model.dart';
import 'package:me_compre/data/providers/firebase_auth_provider.dart';

class LoginRepository {
  static final _provider = FirebaseAuthProvider();

  Future<LoginModel> loginWithEmailAndPassword(
      String email, String senha) async {
    var map = await _provider.loginWithEmailAndPassword(email, senha);

    if (map == null) {
      return null;
    }

    var login = LoginModel.fromMap(map);

    return login;
  }

  Future<LoginModel> createLogin(String email, String senha) async {
    var map = await _provider.createUserWithEmailAndPassword(email: email, senha: senha);

    if (map == null) {
      return null;
    }

    var login = LoginModel.fromMap(map);

    return login;
  }

  void logoff() async {
    await _provider.logoff();
  }

  void changePassword(String email) async {
    await _provider.changePassword(email);
  }

  Future<String> getImageURL() async {
    final imageURL = await _provider.getImageURL();

    return imageURL;
  }
}
