import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentService {
  final String studentID;
  DocumentReference document;
  late DocumentReference classDoc;
  late CollectionReference bookCollection;
  late Map<String, dynamic> studentData;
  late Iterable<String> booksId;
  StudentService({
    required this.studentID,
  }) : document =
            FirebaseFirestore.instance.collection('student').doc(studentID);

  InitService() async {
    studentData = await document
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
    classDoc = FirebaseFirestore.instance
        .collection('classes')
        .doc(studentData['class']);
    bookCollection = document.collection('book');
    booksId =
        await bookCollection.get().then((value) => value.docs.map((e) => e.id));
    print(booksId);
  }

  Future<Map<String, dynamic>> getClass() async {
    final classGet = await classDoc.get();
    return classGet.data() as Map<String, dynamic>;
  }

  logOut(message) async {
    if (message == "berhasil") {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('active_student');
      AuthService.authreload();
    }
  }

  Future<List<Book>> getBooks() async {
    List<Book> books = [];
    for (var i = 0; i < booksId.length; i++) {
      final book = await classDoc
          .collection('book')
          .doc(booksId.elementAt(i))
          .get()
          .then((value) => value.data());
      Map<String, dynamic> data = book as Map<String, dynamic>;
      print(book);
      books.add(Book(
          id: data['id'],
          title: data['title'],
          imageurl: data['image'],
          pdfurl: data['pdf'],
          description: data['description']));
    }
    // await booksId.map((id) async {
    //   final book = await classDoc
    //       .collection('book')
    //       .doc(id)
    //       .get()
    //       .then((value) => value.data());
    //   print(book);
    //   Map<String, dynamic> data = book as Map<String, dynamic>;
    //   print(book);
    //   books.add(Book(
    //       id: data['id'],
    //       title: data['title'],
    //       imageurl: data['image'],
    //       pdfurl: data['pdf'],
    //       description: data['description']));
    // });
    print(books);
    return books;
  }
}
