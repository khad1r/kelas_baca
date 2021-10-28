import 'package:flutter/material.dart';
import 'package:kelas_baca/screen/student/student.dart';
import 'package:kelas_baca/screen/teacher/teacher.dart';
// import 'package:flutter_education_ui/screen/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 350,
            decoration: BoxDecoration(
              // color: Colors.white10,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text('Welcome', style: Theme.of(context).textTheme.headline1),
                SizedBox(height: 85),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 75, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TeacherApp(),
                      ),
                    );
                  },
                  child: Text('Teacher',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 75, vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudentApp(),
                      ),
                    );
                  },
                  child: Text('Student',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
