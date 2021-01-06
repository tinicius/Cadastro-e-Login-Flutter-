import 'package:flutter/material.dart';
import 'package:me_compre/controllers/cadastro_controller.dart';
import 'package:me_compre/views/components/dialog_box/index.dart';
import 'package:me_compre/views/components/flatBottomExtent.dart';
import 'package:me_compre/views/components/textFormFieldExtent.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _controller = CadastroController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            //Imagem de Avatar
            _buildAvatarImage(),

            SizedBox(
              height: 25,
            ),

            //Entradas
            _buildForm(),

            //Botões
            _buildButtons()
          ],
        ),
      ),
    );
  }

  _buildAvatarImage() {
    return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).primaryColor),
        child: _controller.imageURL == null
            ? IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () async {
                  await _controller.escolherFoto(context);
                  setState(() {});
                })
            : Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _controller.retornaFoto(_controller.imageURL))),
              ));
  }

  _buildForm() {
    return Form(
        key: _controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormFieldExt(
              labelText: 'Nome',
              controller: _controller.nomeController,
              validator: _controller.nomeValidator,
            ),
            TextFormFieldExt(
              labelText: 'Sexo',
              controller: _controller.sexoController,
              validator: _controller.sexoValidator,
            ),
            TextFormFieldExt(
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: _controller.emailController,
              validator: _controller.emailValidator,
            ),
            TextFormFieldExt(
              labelText: 'Senha',
              obscureText: true,
              controller: _controller.senhaController,
              validator: _controller.senhaValidator,
            ),
            TextFormFieldExt(
              labelText: 'Confirmar a Senha',
              obscureText: true,
              controller: _controller.conSenhaController,
              validator: _controller.conSenhaValidator,
            ),
          ],
        ));
  }

  bool _isLoading = false;

  _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 15, left: 15),
      child: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FlatButtonExt(
              text: "Cadastrar",
              onPressed: () async {
                setState(() {
                  _isLoading = !_isLoading;
                  print('antes');
                });

                await _controller.submitButton(context);

                setState(() {
                  _isLoading = !_isLoading;
                  print('depous');
                });
              },
            ),
    );
  }
}
