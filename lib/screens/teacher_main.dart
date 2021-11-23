import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/components/profile_pic.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import './teacher_screens/teacher_screens.dart';
import 'teacher_screens/teacher_chat.dart';

class TeacherApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeApp.dark(), title: 'Teacher App', home: TeacherMain());
  }
}

class TeacherMain extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.teacherHome,
      key: ValueKey(AppPages.teacherHome),
      child: TeacherMain(),
    );
  }

  TeacherMain({Key? key}) : super(key: key);

  @override
  _TeacherMainState createState() => _TeacherMainState();
}

class _TeacherMainState extends State<TeacherMain> {
  // 7
  int _selectedIndex = 0;

  // 8
  static List<Widget> pages = <Widget>[
    teacherHome(),
    teacherChat(),
  ];

  // 9
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 75,
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
          IconButton(
              onPressed: () async {
                Provider.of<ProfileManager>(context, listen: false)
                    .tapOnProfile(true);
              },
              icon: Icon(Icons.person)),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: Theme.of(context).textTheme.bodyText1,
        unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
