import 'package:cloud_firestore/cloud_firestore.dart';

class ChildService {
  DocumentReference document;
  String id;
  late String classId;
  ChildService({required this.id})
      : document = FirebaseFirestore.instance.collection('student').doc(id);

  init() async {}

  String get getId => document.id;

  Future<String> getClassId() async {
    classId = await FirebaseFirestore.instance
        .collection('student')
        .doc(id)
        .get()
        .then((value) => value.data()!['class'] as String);
    final classes = await FirebaseFirestore.instance
        .collection('classes')
        .doc(classId)
        .get();
    if (!classes.exists) {
      classId = '';
      await document.update({'class': ''});
    }
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

  Future<Map<String, dynamic>> getChild() async {
    final childget = await document.get();
    return childget.data() as Map<String, dynamic>;
  }

  Stream<QuerySnapshot> getBooks() {
    return FirebaseFirestore.instance
        .collection('classes')
        .doc(classId)
        .collection('book')
        .snapshots();
  }

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

  delete() {
    document.delete().then((value) => print('Deleted'));
  }
}
