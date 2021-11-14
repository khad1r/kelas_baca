import 'package:flutter/material.dart';
import 'package:kelas_baca/screens/teacher_screens/_class_screen.dart';
import './teacher_screens.dart';
import 'class_create.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart'

class teacherHome extends StatelessWidget {
  teacherHome({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> kelas = ["Kelas 1", "Kelas 2", "Kelas 3", "Kelas 4", "Kelas 5"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue[900],
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //             // 1
//             final manager = Provider.of<GroceryManager>(context, listen: false);
// // 2
            Navigator.push(
              context,
              // 3
              MaterialPageRoute(
                // 4
                builder: (context) => ClassCreate(
                  // 5
                  // onCreate: (item) {
                  onCreate: () {
                    // // 6
                    // manager.addItem(item);
                    // // 7
                    // Navigator.pop(context);
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
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClassScreen(),
                                  ),
                                );
                              },
                              child: ClassCard(kelas[index]));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: kelas.length),
                  ),
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
