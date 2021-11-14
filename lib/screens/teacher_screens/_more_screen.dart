import 'package:flutter/material.dart';
import 'package:kelas_baca/screens/splash_screen.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class teacherMore extends StatelessWidget {
  teacherMore({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.blueAccent,
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
                    primary: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  child: Icon(Icons.arrow_back)),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "[Nama]",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Guru",
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
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0))),
                        child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        //TODO

                                        // await Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         EditProfileWidget(),
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24, 0, 0, 0),
                                              child: Text('Edit Profil',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.9, 0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xFF95A1AC),
                                                  size: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        //TODO

                                        // await Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         ChangePasswordWidget(),
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(24, 0, 0, 0),
                                              child: Text('Reset Password',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.9, 0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xFF95A1AC),
                                                  size: 18,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 2,
                                        primary: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 75, vertical: 20),
                                      ),
                                      onPressed: () async {
                                        //TODO

                                        // try {
                                        //   await signOut();
                                        await Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SplashScreen(),
                                          ),
                                          (r) => false,
                                        );
                                        // } finally {
                                        //   Print("logout")
                                        // }
                                      },
                                      child: Text('Log Out',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ),
                                  ],
                                ),
                              ),
                            ])))
              ],
            )
          ])),
    );
  }
}
