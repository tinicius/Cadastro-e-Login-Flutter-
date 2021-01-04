import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:me_compre/routes/all_routes.dart';
import 'package:me_compre/routes/auth_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FirebaseInitApp());
}

class FirebaseInitApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Container(child: Text('Erro ao inicializar o Firebase'));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      routes: AllRoutes.routes,
      initialRoute: AuthRoutes.LOGIN,
    );
  }
}
