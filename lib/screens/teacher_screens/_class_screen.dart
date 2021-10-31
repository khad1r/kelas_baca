import 'package:flutter/material.dart';
import './_class_setting.dart';

// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.blue[900],
        body: Stack(fit: StackFit.expand, children: [
          Positioned(
            left: 0,
            top: 10,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                child: Icon(Icons.arrow_back)),
          ),
          Positioned(
            right: 0,
            top: 10,
            child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassSetting(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      "[Nama Kelas]",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Kelas #",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(35),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0))),
                      child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            InkWell(
                              onTap: () async {
                                //TODO
                              },
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Center(
                                        child: Text(
                                          'Pengumuman',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        '[Pengumuman]',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TextField(
                                style: TextStyle(color: Colors.white30),
                                cursorColor: Colors.white30,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.blueAccent.withOpacity(0.5),
                                  filled: true,
                                  hintText: "Cari",
                                  hintStyle: TextStyle(color: Colors.white30),
                                  prefixIcon: Icon(Icons.search,
                                      color: Colors.white30, size: 26.0),
                                ),
                              ),
                            ),
                            Text("Siswa",
                                style: Theme.of(context).textTheme.headline6),
                            //TODO: Make student avatar
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(8),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ])))
            ],
          ),
        ]));
  }
}
