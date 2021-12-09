import 'package:cloud_firestore/cloud_firestore.dart';

import './kelas_baca_services.dart';

class ParentService {
  final String parentID;
  late final docRef;
  final CollectionReference studentCollection =
      FirebaseFirestore.instance.collection('student');
  final CollectionReference classRef =
      FirebaseFirestore.instance.collection('classes');
  ChildService? childDoc;

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
      'class': '',
      'favorite': [],
    }).then((value) => print('Child Added'));
  }

  Future<DocumentSnapshot> get getInfo =>
      FirebaseFirestore.instance.collection('user').doc(parentID).get();

  setChild(String documentId) {
    childDoc = ChildService(id: documentId);
    childDoc!.init();
  }
}
