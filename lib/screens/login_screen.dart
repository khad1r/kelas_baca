import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './teacher_main.dart';
import './signup_scereen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool passwordVisibility = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey[800],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              // ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kelas Baca",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w800,
                            fontSize: 50)),
                    Text("Teacher",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w800,
                            fontSize: 20)),
                  ])),
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
                            controller: emailTextController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              hintText: 'Masukan Email...',
                              hintStyle: Theme.of(context).textTheme.bodyText1,
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
                              fillColor: Colors.blueAccent.withOpacity(0.5),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.blueAccent,
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordTextController,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              hintText: 'Masukan Password...',
                              hintStyle: Theme.of(context).textTheme.bodyText1,
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
                              fillColor: Colors.blueAccent.withOpacity(0.5),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.blueAccent,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0x80FFFFFF),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'That password doesn\'t match.';
                              }

                              return null;
                            },
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
                              await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TeacherApp(),
                                  ),
                                  (r) => false);
                            },
                            child: Text('Login',
                                style: Theme.of(context).textTheme.bodyText1),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 6, 0),
                                  child: Text('Belum punya akun?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                                InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp(),
                                        ),
                                      );
                                    },
                                    child: Text('Daftar',
                                        style: GoogleFonts.openSans(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueAccent,
                                        )))
                              ],
                            ),
                          )
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
