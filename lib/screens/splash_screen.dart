import 'package:flutter/material.dart';
import 'package:kelas_baca/screens/student_screens/student_screens.dart';
import '../theme.dart';
import './login_screen.dart';
import 'student_screens/_student_login.dart';
// import 'package:kelas_baca/screen/teacher/teacher.dart';
// import 'package:flutter_education_ui/screen/signup_screen.dart';

class InitialaizeApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeApp.dark(), title: 'Initialaize', home: SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/splash.png',
            ).image,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 35),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Kelas Baca",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w800,
                            fontSize: 50))
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                primary: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 75, vertical: 10),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text('Mulai',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                primary: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 75, vertical: 10),
                              ),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentLogin(),
                                  ),
                                );
                              },
                              child: Text('Student',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
