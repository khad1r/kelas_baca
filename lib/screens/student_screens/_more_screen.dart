import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './student_screens.dart';

class StudentMore extends StatelessWidget {
  StudentMore({Key? key}) : super(key: key);

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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Text("[Student Name]",
                          style: Theme.of(context).textTheme.headline2),
                    ),
                  ])),
          Container(
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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 8),
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
                          '[Pengumuman]',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      )
                    ],
                  )
                ],
              ))
        ]));
  }
}
