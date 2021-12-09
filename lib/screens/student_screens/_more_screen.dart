import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/components/components.dart';
import 'package:provider/provider.dart';
import './student_screens.dart';

class StudentMore extends StatefulWidget {
  StudentMore({Key? key}) : super(key: key);

  @override
  State<StudentMore> createState() => _StudentMoreState();
}

class _StudentMoreState extends State<StudentMore> {
  late StudentService studentService;
  void didChangeDependencies() {
    super.didChangeDependencies();
    studentService = Provider.of<Service>(context, listen: false).userService;
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
            )),
        body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 1,
                ),
              ),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Text(studentService.studentData['name'],
                            style: Theme.of(context).textTheme.headline2),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.blue[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0))),
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: ModalLogout(),
                                );
                              });
                        },
                        icon: Icon(Icons.logout_rounded))
                  ])),
          FutureBuilder<Map<String, dynamic>>(
            future: studentService.getClass(),
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                          child: Text(
                            'Informasi Kelas',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 0, 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kelas ${snapshot.data!['teacher_name']}',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  snapshot.data!['name'],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            )),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  'Pengumuman',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                snapshot.data!['Annoucement'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )
                          ],
                        )
                      ],
                    ));
              } else {
                // 10
                return SizedBox(
                  height: 500,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
            },
          )
        ]));
  }
}
