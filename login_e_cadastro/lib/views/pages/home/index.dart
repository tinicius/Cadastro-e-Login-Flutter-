import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_compre/main.dart';

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback openContainer;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  a() async {
    List a = new List();
    a.add(1);
    a.add(1);
    a.add(1);
    a.add(1);
    a.add(1);
    a.add(1);
    a.add(1);

    return a;
  }

  final fAuth = FirebaseAuth.instance;
  final aa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    aa.text = fAuth.currentUser.photoURL;

    return Scaffold(
      body: FutureBuilder(
        //future: fAuth.currentUser,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(fAuth.currentUser.uid),
              
            ],
          );
        },
      ),
    );
  }
}
