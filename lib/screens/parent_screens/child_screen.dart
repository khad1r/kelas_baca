import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/components/components.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:provider/provider.dart';

import 'child_screen_empty.dart';
import 'child_screen_home.dart';
import 'child_setting.dart';

class ChildScreen extends StatelessWidget {
  ChildScreen({Key? key}) : super(key: key);
  ChildService? childService;

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Service>(context, listen: false).userService;
    if (service is ParentService) {
      childService = service.childDoc;
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.blueAccent,
            body: Stack(fit: StackFit.expand, children: [
              Positioned(
                left: 0,
                top: 10,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      childService = null;
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                    child: Icon(Icons.arrow_back)),
              ),
              Positioned(
                right: 0,
                top: 10,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChildSetting(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    child: FutureBuilder<Map<String, dynamic>>(
                        future: childService!.getChild(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!['name'],
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Text(
                                  "${snapshot.data!['Age']} Tahun",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ],
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
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
                          child: FutureBuilder(
                            future: childService!.getClassId(),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.data != "") {
                                return ChildScreenHome();
                              } else {
                                return EmptyClass();
                              }
                            },
                          )))
                ],
              ),
            ])));
  }
}
