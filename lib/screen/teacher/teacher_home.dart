import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class teacherHome extends StatelessWidget {
  // 2
  @override
  Widget build(BuildContext context) {
    // 3
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 16, 0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.blueAccent,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
              child: Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ProfilePicture(
                  name: 'Aditya Dharmawan',
                  radius: 14,
                  fontsize: 12,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
            child: Text("Aditya Dharmawan",
                style: Theme.of(context).textTheme.headline2),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: InkWell(
                      // onTap: () async {
                      //   await launchURL('tel:1234567890');
                      // },
                      child: Material(
                        color: Colors.transparent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kelas 1',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                // Expanded(
                                //   child: Padding(
                                //     padding: EdgeInsetsDirectional.fromSTEB(
                                //         0, 0, 0, 8),
                                //     child: Text(
                                //         'Give us a call in order to schedule your appointment.',
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodyText1),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
