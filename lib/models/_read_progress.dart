part of './student_reads.dart';

enum status { Belum, Sedang, Selesai }

class ReadProgress {
  status statusbaca;
  int bookIndex;
  ReadProgress({this.statusbaca = status.Belum, required this.bookIndex});
  factory ReadProgress.fromJson(Map<String, dynamic> json) {
    return ReadProgress(
      statusbaca: json['statusbaca'] ?? status.Belum,
      bookIndex: json['bookIndex'] ?? '',
    );
  }
}
