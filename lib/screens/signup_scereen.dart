import 'package:flutter/material.dart';
import './teacher_main.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController confirmPasswordTextController = TextEditingController();
  bool passwordVisibility2 = false;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool passwordVisibility1 = false;
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
                            controller: fullNameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              hintText: 'Masukan Nama Lengkap...',
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
                                Icons.person_outline_rounded,
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
                            obscureText: !passwordVisibility1,
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
                                  () => passwordVisibility1 =
                                      !passwordVisibility1,
                                ),
                                child: Icon(
                                  passwordVisibility1
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0x80FFFFFF),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confirmPasswordTextController,
                            obscureText: !passwordVisibility2,
                            decoration: InputDecoration(
                              labelText: 'Konfirmasi Password',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              hintText: 'Konfirmasi Password...',
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
                                  () => passwordVisibility2 =
                                      !passwordVisibility2,
                                ),
                                child: Icon(
                                  passwordVisibility2
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0x80FFFFFF),
                                  size: 22,
                                ),
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
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
                              try {
                                if (passwordTextController.text !=
                                    confirmPasswordTextController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Passwords don't match!",
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TeacherApp(),
                                    ),
                                    (r) => false);
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text('Lanjut',
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
