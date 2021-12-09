import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class StudentService {
  final String studentID;
  DocumentReference document;
  late DocumentReference classDoc;
  late CollectionReference bookCollection;
  late Map<String, dynamic> studentData;
  late List _favoriteList;
  late Iterable<String> booksId;
  StudentService({
    required this.studentID,
  }) : document =
            FirebaseFirestore.instance.collection('student').doc(studentID);

  InitService() async {
    studentData = await document
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
    _favoriteList = studentData['favorite'];
    classDoc = FirebaseFirestore.instance
        .collection('classes')
        .doc(studentData['class']);
    bookCollection = document.collection('book');
    booksId =
        await bookCollection.get().then((value) => value.docs.map((e) => e.id));
    print(booksId);
  }

  List get getFavoriteList => _favoriteList;

  addFavorite(String id) {
    _favoriteList.add(id);
    updateFavorite();
  }

  removeFavorite(String id) {
    _favoriteList.removeWhere((element) => element == id);
    updateFavorite();
  }

  bool isFavorited(String id) {
    return _favoriteList.contains(id);
  }

  updateFavorite() => document.update({'favorite': _favoriteList});

  Future<Map<String, dynamic>> getClass() async {
    final classGet = await classDoc.get();
    return classGet.data() as Map<String, dynamic>;
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
      books.add(Book(
          id: data['id'],
          title: data['title'],
          imageurl: data['image'],
          pdfurl: data['pdf'],
          description: data['description']));
    }

    return books;
  }

  Future<List<Book>> getFavoriteBooks() async {
    List<Book> books = [];
    for (var i = 0; i < _favoriteList.length; i++) {
      final book = await classDoc
          .collection('book')
          .doc(_favoriteList[i])
          .get()
          .then((value) => value.data());
      Map<String, dynamic> data = book as Map<String, dynamic>;
      books.add(Book(
          id: data['id'],
          title: data['title'],
          imageurl: data['image'],
          pdfurl: data['pdf'],
          description: data['description']));
    }

    return books;
  }
}
