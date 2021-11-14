import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/components.dart';
import 'student_screens/student_screens.dart';

// 1
class StudentApp extends StatelessWidget {
  StudentApp({Key? key}) : super(key: key);

  String name = "Putra Siyang";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.blueAccent,
          statusBarColor: Colors.blueAccent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.blueAccent,
          //Navigation bar divider color
          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icon
        ),
        title: Text(
          'Kelas Baca',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          profileButton(context),
        ],
      ),
      body: StudentHome(),
    );
  }

  Widget profileButton(context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
          child: ProfilePicture(
            name: name,
          ),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentMore(),
              ),
            );
          }),
    );
  }
}
