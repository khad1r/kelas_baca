class studentRead {
  String name;
  List<progress> readings;
  studentRead(this.name, this.readings);
}

class progress {
  String status;
  int bookIndex;
  progress(this.status, this.bookIndex);
}
