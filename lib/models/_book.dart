import 'dart:io';

class Book {
  String id;
  String title;
  String imageurl;
  String description;
  String pdfurl;

  Book(
      {required this.id,
      required this.title,
      required this.imageurl,
      this.description = '',
      required this.pdfurl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageurl: json['imageurl'] ?? '',
      description: json['description'] ?? '',
      pdfurl: json['pdfurl'] ?? '',
    );
  }
}

class BookRaw {
  String id;
  String title;
  File? image;
  String description;
  File? pdf;

  BookRaw(
      {required this.id,
      required this.title,
      this.image,
      this.description = '',
      this.pdf});

  // factory BookRaw.fromJson(Map<String, dynamic> json) {
  //   return BookRaw(
  //     id: json['id'] ?? '',
  //     title: json['title'] ?? '',
  //     imageurl: json['imageurl'] ?? '',
  //     description: json['description'] ?? '',
  //     pdfurl: json['pdfurl'] ?? '',
  //   );
  // }
}

class BookStudent {
  String id;
  int progress;

  BookStudent({
    required this.id,
    this.progress = 0,
  });

  factory BookStudent.fromJson(Map<String, dynamic> json) {
    return BookStudent(
      id: json['id'] ?? '',
      progress: json['progress'] ?? 0,
    );
  }
}
