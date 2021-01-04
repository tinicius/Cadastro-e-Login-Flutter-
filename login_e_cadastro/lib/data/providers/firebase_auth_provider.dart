import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseAuthProvider {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //Efetuar login
  Stream<Map> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map((User currentUser) => {
            'id': currentUser.uid,
            'displayName': currentUser.displayName,
            'email': currentUser.email,
            'photoURL': currentUser.photoURL,
            'phoneNumber': currentUser.phoneNumber
          });

  Future<Map> loginWithEmailAndPassword(String email, String senha) async {
    
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);

      return {
        'id': userCredential.user.uid,
        'displayName': userCredential.user.displayName,
        'email': userCredential.user.email,
        'photoURL': userCredential.user.photoURL,
        'phoneNumber': userCredential.user.phoneNumber
      };
      
  }

  //Criar conta
  Future<Map> createUserWithEmailAndPassword(
      {@required String email,
      @required String senha,
      String nome,
      String fotoURL,
      String telefone}) async {
   
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: senha);

      await _firebaseStorage
          .ref('dadosDosUsuarios/imagensDePerfil/${userCredential.user.uid}')
          .putFile(File(fotoURL));

      var fotoUpload = await _firebaseStorage
          .ref('dadosDosUsuarios/imagensDePerfil/${userCredential.user.uid}')
          .getDownloadURL();

      await userCredential.user
          .updateProfile(displayName: nome, photoURL: fotoUpload);

      return {
        'id': userCredential.user.uid,
        'displayName': userCredential.user.displayName,
        'email': userCredential.user.email,
        'photoURL': userCredential.user.photoURL,
        'phoneNumber': userCredential.user.phoneNumber
      };
    
      
    
  }

  //Efetuar Logoff

  Future<void> logoff() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Recuperar senha
  Future<void> changePassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Imagem

  Future<String> getImageURL() async {
    try {
      final storage = FirebaseStorage.instance;
      final imageURL =
          await storage.ref("assets/imagens/login_avatar.jpg").getDownloadURL();

      return imageURL;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
