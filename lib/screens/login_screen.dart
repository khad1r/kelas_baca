import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'screens.dart';

class LoginScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.loginPath,
      key: ValueKey(AppPages.loginPath),
      child: const LoginScreen(),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool passwordVisibility = false;
  String? _message;
  bool _loading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  child: _buildForm(),
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

  Widget _buildForm() {
    return Form(
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
          _buildInput(
            textController: emailTextController,
            label: "E-mail",
            hint: "Masukan Email...",
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
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
          _buildInput(
            textController: passwordTextController,
            label: "Password",
            keyboardType: TextInputType.visiblePassword,
            hint: "Masukan Password...",
            icon: Icons.lock_outline,
            obscurity: !passwordVisibility,
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
              padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
            ),
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;

              setState(() {
                _loading = true;
                _login();
              });
            },
            child: Text('Login', style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }

  _login() async {
    try {
      Provider.of<AppStateManager>(context, listen: false).login(
          email: emailTextController.text,
          password: passwordTextController.text);
    } catch (e) {
      setState(() {
        _message = e.toString();
        _loading = false;
      });
    }
  }

  Widget _buildInput(
      {required String label,
      required String hint,
      required IconData icon,
      TextInputType? keyboardType,
      required TextEditingController textController,
      Widget? suffixIcon,
      bool obscurity = false,
      required Function(String?) validator}) {
    return TextFormField(
        controller: textController,
        obscureText: obscurity,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            hintText: hint,
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
              icon,
              color: Colors.blueAccent,
            ),
            suffixIcon: suffixIcon),
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: keyboardType,
        validator: (String? value) {
          validator(value);
        });
  }
}
