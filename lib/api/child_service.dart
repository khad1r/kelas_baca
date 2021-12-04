import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kelas_baca/models/models.dart';

class ChildService {
  DocumentReference document;
  String id;
  late String classId;
  ChildService({required this.id})
      : document = FirebaseFirestore.instance.collection('student').doc(id);

  init() async {}

  String getId() {
    return document.id;
  }

  Future<String> getClassId() async {
    classId = await FirebaseFirestore.instance
        .collection('student')
        .doc(id)
        .get()
        .then((value) => value.data()!['class'] as String);
    return classId;
  }

  Future<String> setClass(classid) async {
    final classes = await FirebaseFirestore.instance
        .collection('classes')
        .doc(classid)
        .get();
    if (!classes.exists)
      return 'Class Tidak Ada';
    else {
      await document.update({'class': classid});
    }
    return 'Proses Berhasil';
  }

  Stream<DocumentSnapshot> getChild() {
    return document.snapshots();
  }

  Stream<QuerySnapshot> getBooks() {
    return FirebaseFirestore.instance
        .collection('classes')
        .doc(classId)
        .collection('book')
        .snapshots();
  }

  // Future<List<Book>> getClassBook() async {
  //   final books = await FirebaseFirestore.instance
  //       .collection('classes')
  //       .doc(classId)
  //       .collection('book')
  //       .get();
  //   List<Book> booksss = [];
  //   for (var book in books.docs) {
  //     document.collection('book').doc(book.id).get().then((value) => {
  //           if (!value.exists)
  //             {
  //               booksss.add(Book(
  //                   id: book.data()['id'],
  //                   title: book.data()['title'],
  //                   imageurl: book.data()['image'],
  //                   pdfurl: book.data()['pdf'],
  //                   description: book.data()['description']))
  //             }
  //         });
  //   }

  //   return booksss;
  // }

  Future<DocumentSnapshot> getChildBook(String bookId) async {
    return await document.collection('book').doc(bookId).get();
  }

  Future<String> getProgress(String bookId) {
    return document
        .collection('book')
        .doc(bookId)
        .get()
        .then((value) => value.data()!['progress'] as String);
  }

  addToList(bookId) async {
    document.collection('book').doc(bookId).set({'progress': 0});
  }

  deleteFromList(bookId) {
    document.collection('book').doc(bookId).delete();
  }

  login() {}

  delete() {
    document.delete().then((value) => print("Deleted"))
        // .catchError((error) => print("Failed to delete: $error"))
        ;
  }

  // updateName(String name) {
  //   document.update({'name': name}).then((value) => print("Updated"))
  //       // .catchError((error) => print("Failed to update: $error"))
  //       ;
  // }

  // Stream<QuerySnapshot> getBooks() {
  //   return document.collection('book').snapshots();
  // }
}
