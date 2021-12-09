import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../api/kelas_baca_services.dart';
import '../models/models.dart';
import '../components/components.dart';
import 'student_screens/student_screens.dart';

// 1
class StudentMain extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.studentHome,
      key: ValueKey(AppPages.studentHome),
      child: StudentMain(),
    );
  }

  StudentMain({Key? key}) : super(key: key);

  @override
  State<StudentMain> createState() => _StudentMainState();
}

class _StudentMainState extends State<StudentMain> {
  String name = '';
  late StudentService studentService;
  void didChangeDependencies() {
    super.didChangeDependencies();
    studentService = Provider.of<Service>(context, listen: false).userService;
    name = studentService.studentData['name'];
  }

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
