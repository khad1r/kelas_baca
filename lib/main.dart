import 'package:flutter/material.dart';
// import 'package:kelas_baca/screen/Login.dart';
import 'package:kelas_baca/theme/theme.dart';
import 'package:kelas_baca/screens/student.dart';

void main() {
  runApp(const KelasBaca());
}

class KelasBaca extends StatelessWidget {
  const KelasBaca({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeApp.dark(),
      title: 'Kelas Baca',
      home: const StudentApp(),
    );
  }
}
