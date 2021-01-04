import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:me_compre/data/repositories/login_repository.dart';
import 'package:me_compre/routes/app_routes.dart';
import 'package:me_compre/routes/auth_routes.dart';
import 'package:me_compre/views/components/dialog_box/index.dart';

class LoginController {
  final _repository = LoginRepository();

  final formKey = new GlobalKey<FormState>();

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  String emailValidator(String value) {
    if (value.isEmpty) {
      return 'Campo Vazio';
    } else if (!value.contains('@') || !value.contains('.com')) {
      return 'Email Inválido';
    }

    return null;
  }

  String senhaValidator(String value) {
    if (value.isEmpty) {
      return 'Campo Vazio';
    } else if (value.length < 8) {
      return 'A senha deve conter 8 caracteres';
    }

    return null;
  }

  void entrar(BuildContext context) async {
    if (formKey.currentState.validate()) {
      try {
        var login = await _repository.loginWithEmailAndPassword(
            emailController.text, senhaController.text);
      } catch (e) {
        Exception exception = e;
        DialogBox()
            .showWarning(context, titulo: 'Erro', texto: exception.toString());
      }
    }
  }

  void recuperarSenha(BuildContext context) async {
    var dialog = new DialogBox();

    if (emailController.text.isEmpty) {
      dialog.showWarning(context,
          titulo: "ATENÇÃO", texto: "Email não informado");
    }

    _repository.changePassword(emailController.text);

    dialog.showOK(context,
        titulo: "Sucesso", texto: "Foi enviado um \nemail de recuperação");
  }

  void criarConta(BuildContext context) async {
    Navigator.of(context).pushNamed(AuthRoutes.CADASTRO);
  }

  getImage() async {
    try {
      var imageURL = await _repository.getImageURL();

      return NetworkImage(imageURL, scale: 0.4);
    } catch (e) {
      return null;
    }
  }
}
