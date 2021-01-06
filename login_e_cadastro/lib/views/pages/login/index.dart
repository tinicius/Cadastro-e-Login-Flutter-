import 'package:flutter/material.dart';
import 'package:me_compre/controllers/login_controller.dart';
import 'package:me_compre/views/components/flatBottomExtent.dart';
import 'package:me_compre/views/components/textFormFieldExtent.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = LoginController();
    final fAuth = FirebaseAuth.instance;


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
                  validator: loginController.emailValidator),
              TextFormFieldExt(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.vpn_key),
                keyboardType: TextInputType.visiblePassword,
                controller: loginController.senhaController,
                validator: loginController.senhaValidator,
                obscureText: true,
              ),

              SizedBox(
                height: 25,
              ),

              //Botões

              (loginController.isLoading)
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : FlatButtonExt(
                      text: "Entrar",
                      onPressed: () async {
                        setState(() {
                          loginController.changeLoading();
                        });

                        await loginController.entrar(context);

                        setState(() {
                          loginController.changeLoading();
                        });
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
