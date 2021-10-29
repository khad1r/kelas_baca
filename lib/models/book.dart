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
      title: json['Title'] ?? '',
      imageurl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      pdfurl: json['pdfurl'] ?? '',
    );
  }
}
