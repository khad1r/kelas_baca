import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_baca/api/service.dart';
import 'package:provider/provider.dart';
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
  String? _message;
  bool _loading = false;
  var authservice;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    authservice = Provider.of<Service>(context).auth;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[900], //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blue[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // physics: BouncingScrollPhysics(),
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              // ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kelas Baca",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 50)),
                  ])),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 36),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(25),
                          child: _loading
                              ? CircularProgressIndicator()
                              : Text('${_message ?? ''}',
                                  style: Theme.of(context).textTheme.bodyText1),
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
                          validator: (String? value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Masukan Email yang benar!';
                            }
                            return null;
                          },
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
                                () => passwordVisibility = !passwordVisibility,
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong!';
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
                            if (!_formKey.currentState!.validate()) return;

                            setState(() {
                              _loading = true;
                              _login();
                            });
                          },
                          child: Text('Login',
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: 100,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Belum punya akun? Daftar Sebagai',
                      style: Theme.of(context).textTheme.bodyText1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Daftar Sebagai ',
                          style: Theme.of(context).textTheme.bodyText1),
                      InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(
                                  signUpType: "Teacher",
                                ),
                              ),
                            );
                          },
                          child: Text('Guru',
                              style: GoogleFonts.openSans(
                                decoration: TextDecoration.underline,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue[200],
                              ))),
                      Text(' atau ',
                          style: Theme.of(context).textTheme.bodyText1),
                      InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(
                                  signUpType: "Parent",
                                ),
                              ),
                            );
                          },
                          child: Text('Orang tua',
                              style: GoogleFonts.openSans(
                                decoration: TextDecoration.underline,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue[200],
                              ))),
                    ],
                  ),
                ]),
          )
        ],
      ),
    );
  }

  _login() async {
    try {
      _message = await authservice.signIn(
          email: emailTextController.text,
          password: passwordTextController.text);
    } catch (e) {
      setState(() {
        _message = e.toString();
        _loading = false;
      });
    }
  }
}
