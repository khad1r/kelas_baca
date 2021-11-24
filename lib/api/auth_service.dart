import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelas_baca/api/service.dart';

import 'firebase_services.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userType;

  Stream<User?> get userChanges => _firebaseAuth.userChanges();

  User? get getUser => _firebaseAuth.currentUser;

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
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
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final userData = await FirebaseFirestore.instance
          .collection('user')
          .doc(credentials.user!.uid)
          .get();
      _firebaseAuth.currentUser!.reload();
      return "Login berhasil";
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password" ||
          e.code == "user-not-found" ||
          e.code == "invalid-email") {
        throw ("Email atau Password salah!!");
      }
      if (e.code == "too-many-requests") {
        throw ("Terlalu banyak request, coba lagi beberapa saat..");
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
      _firebaseAuth.currentUser!.reload();
      return "Sign Up berhasil";
    } on FirebaseAuthException catch (e) {
      if (e.code == "too-many-requests") {
        throw ("Terlalu banyak request, coba lagi beberapa saat..");
      }
      if (e.code == "email-already-in-use") {
        throw ("Email telah digunakan!!");
      } else
        throw (e.message.toString());
    }
  }

  signOut() {
    _firebaseAuth.signOut();
  }
}
