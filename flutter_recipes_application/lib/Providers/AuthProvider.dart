import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('Sign up successful: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      print('Sign up failed: $e');
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      print('Sign in successful: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      print('Sign in failed: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      print('Sign out successful');
    } on FirebaseAuthException catch (e) {
      print('Sign out failed: $e');
      rethrow;
    }
  }
}