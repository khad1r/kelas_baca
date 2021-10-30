import 'package:flutter/material.dart';
import './student_screens.dart';

class StudentMore extends StatelessWidget {
  StudentMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text("[Student Name]",
                      style: Theme.of(context).textTheme.headline2),
                ),
              ])),
      Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black54,
          ),
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
              InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentClassCode(
                              // displayName: myProfileUsersRecord,
                              // email: myProfileUsersRecord,
                              )),
                    );
                  },
                  child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kelas [Nama Guru]',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '[Kelas]',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 12, 8),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 24,
                            ),
                          )
                        ],
                      ))),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                child: Column(
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
                        '[Pengumuman]',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  ],
                ),
              )
            ],
          ))
    ]));
  }
}
