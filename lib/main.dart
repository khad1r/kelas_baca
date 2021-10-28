import 'package:flutter/material.dart';
import 'package:kelas_baca/screen/Login.dart';
import 'package:kelas_baca/theme/theme.dart';

void main() => runApp(MaterialApp(
      theme: ThemeApp.dark(),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    ));
