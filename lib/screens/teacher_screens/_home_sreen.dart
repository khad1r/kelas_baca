import 'package:flutter/material.dart';
import 'package:kelas_baca/api/kelas_baca_services.dart';
import 'package:kelas_baca/api/_service.dart';
import 'package:kelas_baca/screens/teacher_screens/_class_screen.dart';
import 'package:provider/provider.dart';
import './teacher_screens.dart';
import 'class_create.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart'

class teacherHome extends StatefulWidget {
  teacherHome({Key? key}) : super(key: key);

  @override
  State<teacherHome> createState() => _teacherHomeState();
}

class _teacherHomeState extends State<teacherHome> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final TeacherService teacherService =
        Provider.of<Service>(context, listen: false).userService;
    final name = Provider.of<Service>(context, listen: false).getUserData!.Name;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue[900],
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              // 3
              MaterialPageRoute(
                // 4
                builder: (context) => ClassCreate(
                  onCreate: (className) {
                    teacherService.createClass(className, name);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                ),
              ),
            );
          },
          backgroundColor: Colors.blueAccent,
          elevation: 8,
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Kelas',
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: teacherService.getClasses(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('Something went wrong'));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            return ListView(
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return InkWell(
                                  onTap: () {
                                    teacherService.setClass(document.id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ClassScreen(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: ClassCard(data["name"]),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      )),
                )
              ],
            ),
          ),
        ));
  }
}

Widget ClassCard(String kelas) {
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black26),
      boxShadow: [
        BoxShadow(
            color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0)
      ],
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 25, 0, 25),
            child: Text(kelas,
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w800,
                    fontSize: 20)),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 25, 12, 25),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 24,
              ),
            )
          ],
        )
      ],
    ),
  );
}
