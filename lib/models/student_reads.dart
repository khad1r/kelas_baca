part '_read_progress.dart';

class studentRead {
  String name;
  List<ReadProgress> readings;
  studentRead({required this.name, this.readings = const []});

  factory studentRead.fromJson(Map<String, dynamic> json) {
    final readProgress = <ReadProgress>[];

    if (json['readProgress'] != null) {
      json['readProgress'].forEach((v) {
        readProgress.add(ReadProgress.fromJson(v));
      });
    }
    return new studentRead(
      name: json['name'] ?? '',
      readings: readProgress,
    );
  }
}
