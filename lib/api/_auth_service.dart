import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static String userId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userType;

  Stream<User?> get userChanges => _firebaseAuth.userChanges();

  User? get getUser => _firebaseAuth.currentUser;

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  reload() {
    if (_firebaseAuth.currentUser != null) _firebaseAuth.currentUser!.reload();
  }

  Future<String> get getRole => FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) => value.data()!['role'] as String);

  Future<Map<String, dynamic>> get userData => FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => value.data() as Map<String, dynamic>);

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return 'Login berhasil';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' ||
          e.code == 'user-not-found' ||
          e.code == 'invalid-email') {
        throw ('Email atau Password salah!!');
      }
      if (e.code == 'too-many-requests') {
        throw ('Terlalu banyak request, coba lagi beberapa saat..');
      }
    }
  }

  Future<String?> signUp(
      {required String name,
      required String email,
      required String password,
      required String role}) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('user')
          .doc(credentials.user!.uid)
          .set({'name': name, 'role': role});
      notifyListeners();
      return 'Sign Up berhasil';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        throw ('Terlalu banyak request, coba lagi beberapa saat..');
      }
      if (e.code == 'email-already-in-use') {
        throw ('Email telah digunakan!!');
      } else
        throw (e.message.toString());
    }
  }

  signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  Future<String?> logOutStudent({required String password}) async {
    try {
      await _firebaseAuth.currentUser!.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser!.email!, password: password));
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('active_student');
      notifyListeners();
      return 'berhasil';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' ||
          e.code == 'user-not-found' ||
          e.code == 'invalid-email') {
        throw ('Password salah!!');
      } else if (e.code == 'too-many-requests') {
        throw ('Terlalu banyak request, coba lagi beberapa saat..');
      } else {
        throw (e.toString());
      }
    }
  }

  Future<String?> logInStudent({required String id}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('active_student', id);
      notifyListeners();
      return 'berhasil';
    } on Exception catch (e) {
      throw (e.toString());
    }
  }
}
