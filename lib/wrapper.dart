import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelas_baca/screens/splash_screen.dart';
import 'package:kelas_baca/theme.dart';
import 'package:provider/src/provider.dart';

import 'api/service.dart';
import 'screens/teacher_main.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Service>(context);
    return StreamBuilder(
        stream: service.auth.userChanges,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return InitialaizeApp();
            }
            if (service.auth == null) {
              return InitialaizeApp();
            }
            if (user != null) {
              if (service.auth.userType == "Teacher") {
                service.teacher(user.uid);
                return TeacherApp();
              }
              if (service.auth.userType == "Parent") {
                print("Parent");
                service.auth.signOut();
              }
              if (service.auth.userType == null) {
                service.auth.signOut();
              }
            }
            ;
          }
          return MaterialApp(
              theme: ThemeApp.dark(),
              title: 'Initialaize',
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ));
        });
  }
}
