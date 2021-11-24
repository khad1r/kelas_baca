import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelas_baca/screens/screens.dart';
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
            if (service.isInitialized)
              return Navigator(
                onPopPage: _handlePopPage,
                pages: [
                  if (!service.auth.isLoggedIn() && service.userService == null)
                    LoginScreen.page(),
                  if (service.auth.isLoggedIn() && service.getRole == "Parent")
                    ParentMain.page(),
                  if (service.auth.isLoggedIn() && service.getRole == "Teacher")
                    TeacherMain.page(),
                ],
              );
            // // final User? user = snapshot.data;
            // if (!service.auth.isLoggedIn() && service.userService == null) {
            //   return LoginScreen();
            // }
            // if (service.auth.isLoggedIn()) {
            //   if (service.getRole == "Teacher") {
            //     return TeacherApp();
            //   }
            //   if (service.getRole == "Parent") {
            //     return ParentApp();
            //   }
            // }
            // ;
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    return true;
  }
}
