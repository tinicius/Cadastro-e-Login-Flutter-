import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_compre/main.dart';
import 'package:me_compre/data/repositories/login_repository.dart';
import 'package:me_compre/routes/auth_routes.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fAuth = FirebaseAuth.instance;
  final aa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    aa.text = fAuth.currentUser.photoURL;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              LoginRepository().logoff();
              Navigator.pushReplacementNamed(context, AuthRoutes.LOGIN);
            },
          )
        ],
      ),
      body: FutureBuilder(
        //future: fAuth.currentUser,
        builder: (context, snapshot) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(fAuth.currentUser.photoURL))),
                  ),
                  Card(
                    child: Text(fAuth.currentUser.displayName),
                  ),
                  Card(
                    child: Text(fAuth.currentUser.email),
                  ),
                  Card(
                    child: Text(fAuth.currentUser.uid),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
