import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelas_baca/screens/splash_screen.dart';
import 'package:kelas_baca/theme.dart';
import 'package:provider/src/provider.dart';

import 'api/service.dart';
import 'screens/Parent_main.dart';
import 'screens/teacher_main.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Service>(context);
    return StreamBuilder(
        stream: service.auth.userChanges,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // final User? user = snapshot.data;
            if (!service.auth.isLoggedIn() && service.userService == null) {
              return InitialaizeApp();
            }
            if (service.auth.isLoggedIn()) {
              if (service.role == "Teacher") {
                return TeacherApp();
              }
              if (service.role == "Parent") {
                return ParentApp();
              }
            }
            ;
          }
          return MaterialApp(
              theme: ThemeApp.light(),
              title: 'Initialaize',
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ));
        });
  }
}
