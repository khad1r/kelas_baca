import 'package:flutter/material.dart';
import '../student_main.dart';

class StudentName extends StatefulWidget {
  StudentName({Key? key}) : super(key: key);

  @override
  _StudentNameState createState() => _StudentNameState();
}

class _StudentNameState extends State<StudentName> {
  TextEditingController classCodeController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey[800],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  // ),
                  child: Center(
                    child: Text("Kelas Baca",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w900,
                            fontSize: 50)),
                  ))
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 36),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextFormField(
                            controller: classCodeController,
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'Nama',
                                labelStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                hintText: 'Masukan Nama Kamu...',
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.blueAccent.withOpacity(0.5)),
                            style: Theme.of(context).textTheme.bodyText1,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 75, vertical: 20),
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentApp(),
                                ),
                              );
                            },
                            child: Text('Masuk',
                                style: Theme.of(context).textTheme.bodyText1),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
