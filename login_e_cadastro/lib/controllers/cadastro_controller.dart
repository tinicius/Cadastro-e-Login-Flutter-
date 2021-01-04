import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:me_compre/routes/app_routes.dart';
import 'package:me_compre/views/components/dialog_box/index.dart';
import 'package:me_compre/data/repositories/cadastro_repository.dart';

class CadastroController {
  final _repository = CadastroRepository();

  String imageURL;

  final formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final sexoController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final conSenhaController = TextEditingController();

  Future<void> submitButton(BuildContext context) async {
    if (formKey.currentState.validate()) {
      var user;

      try {
        user = await _repository.cadastrarUsuario(this.emailController.text,
            this.senhaController.text, this.nomeController.text, imageURL);
      } catch (e) {
        FirebaseAuthException exception = e;

        DialogBox()
            .showWarning(context, titulo: "Erro", texto: exception.message);

        return;
      }

      print('user = ${user.toString()}');

      if (user != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.HOME);
      }
    }
  }

  String nomeValidator(String value) {
    if (value.isEmpty) {
      return 'Campo Vazio';
    }

    return null;
  }

  String sexoValidator(String value) {
    if (value.isEmpty) {
      return 'Campo Vazio';
    }

    return null;
  }

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

  String conSenhaValidator(String value) {
    if (value.isEmpty) {
      return 'Campo Vazio';
    } else if (senhaController.text != conSenhaController.text) {
      return 'As duas senhas não correspondem';
    }

    return null;
  }

  dynamic retornaFoto(String caminho) {
    if (caminho.length == 0) {
      //return AssetImage('assets/images/sem_foto_item.png');
    } else {
      if (caminho.contains('http'))
        try {
          return NetworkImage(caminho);
        } catch (ex) {
          return AssetImage('assets/images/sem_foto_item.png');
        }
      else
        try {
          return FileImage(File(caminho));
        } catch (ex) {
          return AssetImage('assets/images/sem_foto_item.png');
        }
    }
  }

  Future<void> escolherFoto(BuildContext context) async {
    var dialog = new DialogBox();
    final imagePicker = ImagePicker();
    var source;

    var opcao = await dialog.showOpcoes(context,
        titulo: 'Escolha uma foto', options: ['Galeria', 'Câmera']);

    if (opcao == "Galeria") {
      source = ImageSource.gallery;
    } else {
      source = ImageSource.camera;
    }

    var fotoSelecionada = await imagePicker.getImage(source: source);

    this.imageURL = fotoSelecionada.path;
  }
}
