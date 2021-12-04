import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:kelas_baca/models/models.dart';

import 'firebase_services.dart';

class ParentService {
  final String parentID;
  late final docRef;
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('student');
  final CollectionReference classRef =
      FirebaseFirestore.instance.collection('classes');
  late ChildService childDoc;

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
    childDoc = ChildService(id: documentId);
    childDoc.init();
  }
}
