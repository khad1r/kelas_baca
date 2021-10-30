import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './theme.dart';

void main() {
  runApp(const KelasBaca());
}

class KelasBaca extends StatelessWidget {
  const KelasBaca({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = ThemeApp.dark();
    return MaterialApp(
      theme: theme,
      title: 'Kelas Baca',
      home: SplashScreen(),
    );
  }
}
