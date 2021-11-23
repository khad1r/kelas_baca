import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelas_baca/api/service.dart';
import 'package:provider/provider.dart';

class ChildScreen extends StatelessWidget {
  const ChildScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var classService =
        Provider.of<Service>(context, listen: false).userService.childDoc;
    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
          stream: classService.getChild(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Scaffold(
                  backgroundColor: Colors.blueAccent,
                  body: Stack(fit: StackFit.expand, children: [
                    Positioned(
                      left: 0,
                      top: 10,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            classService = null;
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                          ),
                          child: Icon(Icons.arrow_back)),
                    ),
                    Positioned(
                      right: 0,
                      top: 10,
                      child: ElevatedButton(
                          onPressed: () async {
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ClassSetting(
                            //       className: data['name'],
                            //       classCode: classService.getClassId(),
                            //       onDelete: () {
                            //         Navigator.of(context).pop();
                            //         Navigator.of(context).pop();
                            //         classService.deleteClass();
                            //       },
                            //       onNameChange: (newName) {
                            //         classService.updateClassName(newName);
                            //       },
                            //     ),
                            //   ),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                          ),
                          child: Icon(Icons.menu)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data['name'],
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Text(
                                "${data['Age']} Tahun",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(35, 35, 35, 0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        topRight: Radius.circular(50.0))),
                                child: ListView(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    physics: BouncingScrollPhysics(),
                                    children: [
                                      // _buildBooksView(),
                                      // Text(
                                      //   "Siswa",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .headline1,
                                      // ),
                                      // _buildSearchCard(),
                                      // Padding(
                                      //     padding: const EdgeInsets.fromLTRB(
                                      //         5, 15, 5, 15),
                                      //     child: _buildStudentView()),
                                    ])))
                      ],
                    ),
                  ]));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
