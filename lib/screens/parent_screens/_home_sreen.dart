import 'package:flutter/material.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/api/service.dart';
import 'package:kelas_baca/components/components.dart';
import 'package:kelas_baca/screens/parent_screens/child_screen.dart';
import 'package:kelas_baca/screens/teacher_screens/_class_screen.dart';
import 'package:provider/provider.dart';
import 'parent_screens.dart';
import 'add_child.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart'

class ParentHome extends StatefulWidget {
  ParentHome({Key? key}) : super(key: key);

  @override
  State<ParentHome> createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final parentService =
        Provider.of<Service>(context, listen: false).userService;
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
                builder: (context) => AddChild(
                  onCreate: (name, age) {
                    parentService.addChild(name, age);
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
                        'Children',
                        style: Theme.of(context).textTheme.headline2,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: parentService.getChildren(),
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
                                  onTap: () async {
                                    await parentService.setChild(document.id);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChildScreen(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: StudentTile(
                                        name: data['name'],
                                      )),
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
