import 'package:flutter/material.dart';
import 'package:me_compre/controllers/login_controller.dart';
import 'package:me_compre/views/components/flatBottomExtent.dart';
import 'package:me_compre/views/components/textFormFieldExtent.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: loginController.formKey,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              //Imagem

              FutureBuilder(
                future: loginController.getImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircleAvatar(
                      radius: 60,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: snapshot?.data,
                  );
                },
              ),

              SizedBox(
                height: 25,
              ),

              //Entradas

              TextFormFieldExt(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                controller: loginController.emailController,
                validator: loginController.emailValidator
              ),
              TextFormFieldExt(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.vpn_key),
                keyboardType: TextInputType.emailAddress,
                controller: loginController.senhaController,
                validator: loginController.senhaValidator,
              ),

              SizedBox(
                height: 25,
              ),

              //Botões

              FlatButtonExt(
                text: "Entrar",
                onPressed: () {
                  loginController.entrar(context);
                },
              ),
              FlatButtonExt(
                text: "Esqueci a senha",
                onPressed: () {
                  loginController.recuperarSenha(context);
                },
              ),
              FlatButtonExt(
                text: "Criar conta",
                onPressed: () {
                  loginController.criarConta(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
