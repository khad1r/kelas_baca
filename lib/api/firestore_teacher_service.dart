import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:kelas_baca/models/models.dart';

class TeacherService {
  final String teacherID;

  final CollectionReference collection;
  late ClassDoc classDoc;
  TeacherService({required this.teacherID})
      : collection = FirebaseFirestore.instance.collection('classes');

  Stream<QuerySnapshot> getClasses() {
    return collection
        .where(
          'teacher',
          isEqualTo: teacherID,
        )
        .snapshots();
  }

  createClass(String name, String teacher) {
    collection.add({
      'name': name,
      'Annoucement': '',
      'teacher': this.teacherID,
      'teacher_name': teacher,
    }).then((value) => print("Class Added"))
        // .catchError((error) => print("Failed to add Class: $error"))
        ;
  }

  Future<DocumentSnapshot> get getTeacherInfo =>
      FirebaseFirestore.instance.collection('user').doc(teacherID).get();

  setClass(String documentId) {
    classDoc = ClassDoc(classId: documentId, collection: collection);
  }
}

class ClassDoc {
  DocumentReference document;
  ClassDoc({required String classId, required CollectionReference collection})
      : document = collection.doc(classId);

  Stream<DocumentSnapshot> getClass() {
    return document.snapshots();
  }

  String getClassId() {
    return document.id;
  }

  deleteClass() {
    document.delete().then((value) => print("Deleted"))
        // .catchError((error) => print("Failed to delete: $error"))
        ;
  }

  updateClassName(String name) {
    document.update({'name': name}).then((value) => print("Updated"))
        // .catchError((error) => print("Failed to update: $error"))
        ;
  }

  setClassAnnouc(String annoucement) {
    document.update({'Annoucement': annoucement}).then(
            (value) => print("Updated"))
        // .catchError((error) => print("Failed to update: $error"))
        ;
  }

  Stream<QuerySnapshot> getBooks() {
    return document.collection('book').snapshots();
  }

  Stream<QuerySnapshot> get getStudents => FirebaseFirestore.instance
      .collection('student')
      .where('class', isEqualTo: document.id)
      .snapshots();

  addBook(BookRaw book) async {
    CollectionReference booksCollection = document.collection('book');
    final String id = book.id;
    final String title = book.title;
    final String description = book.description;
    final File image = book.image!;
    final File pdf = book.pdf!;
    final pdfUrl = await uploadBookFile(id, '${id}.pdf', pdf);
    final imageUrl = await uploadBookFile(id, '${id}.jpeg', image);

    await booksCollection.doc(id).set({
      'id': id,
      'title': title,
      'description': description,
      'image': imageUrl,
      'pdf': pdfUrl
    });
    print("file Uploaded");
  }

  updateBook(BookRaw book) async {
    CollectionReference booksCollection = document.collection('book');
    final String id = book.id;
    final String title = book.title;
    final String description = book.description;
    final File? image = await book.image;
    final File? pdf = await book.pdf;
    late final pdfUrl;
    late final imageUrl;
    booksCollection.doc(id).update({
      'id': id,
      'title': title,
      'description': description,
    });
    if (pdf != null) {
      pdfUrl = await uploadBookFile(
          id, '${id.split('').reversed.join()}.pdf', compressFile(pdf));
      await booksCollection.doc(id).update({'pdf': pdfUrl});
    }
    if (image != null) {
      imageUrl = await uploadBookFile(
          id, '${id.split('').reversed.join()}.jpeg', compressFile(image));
      await booksCollection.doc(id).update({
        'image': imageUrl,
      });
    }

    print("file Updated");
  }

  deleteBook(String id) async {
    final ref = await FirebaseStorage.instance.ref('book').child(id).listAll()
        // .then((listResults) => {
        //       listResults.items.map((item) => {item.delete()})
        //     });
        ;
    await ref.items[0].delete();
    await ref.items[1].delete();
    await document.collection('book').doc(id).delete();

    print("Book Deleted");
  }

  Future<String> uploadBookFile(id, fileName, file) async {
    final ref =
        FirebaseStorage.instance.ref().child('book').child(id).child(fileName);
    try {
      await ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
    return ref.getDownloadURL();
  }

  Future<File> compressFile(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 5,
    );
    return result!;
  }
}
