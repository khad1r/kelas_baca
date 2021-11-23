import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:kelas_baca/models/models.dart';

class ParentService {
  final String parentID;
  late final docRef;
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('student');
  final CollectionReference classRef =
      FirebaseFirestore.instance.collection('classes');
  late ChildDoc childDoc;

  ParentService({required this.parentID});

  Stream<QuerySnapshot> getChildren() {
    return studentCollection
        .where(
          'Parent',
          isEqualTo: parentID,
        )
        .snapshots();
  }

  addChild(String name, String age) {
    studentCollection.add({
      'name': name,
      'Age': age,
      'Parent': this.parentID,
      'class': ''
    }).then((value) => print("Child Added"))
        // .catchError((error) => print("Failed to add Class: $error"))
        ;
  }

  Future<DocumentSnapshot> get getInfo =>
      FirebaseFirestore.instance.collection('user').doc(parentID).get();

  setChild(String documentId) {
    childDoc = ChildDoc(id: documentId, collection: studentCollection);
  }
}

class ChildDoc {
  DocumentReference document;
  ChildDoc({required String id, required CollectionReference collection})
      : document = collection.doc(id);

  Stream<DocumentSnapshot> getChild() {
    return document.snapshots();
  }

  String getId() {
    return document.id;
  }

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

  Stream<QuerySnapshot> getBooks() {
    return document.collection('book').snapshots();
  }
}
