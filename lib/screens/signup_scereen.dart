import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_baca/api/service.dart';
import 'package:provider/provider.dart';
import './teacher_main.dart';

class SignUp extends StatefulWidget {
  final String signUpType;
  const SignUp({Key? key, required this.signUpType}) : super(key: key);

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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
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
                    Text(widget.signUpType,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20)),
                  ])),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: Row(
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
                        children: [
                          Padding(
                            padding: EdgeInsets.all(25),
                            child: _loading
                                ? CircularProgressIndicator()
                                : Text('${_message ?? ''}',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                          ),
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
                            validator: (String? value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-z A-Z]+$").hasMatch(value)) {
                                return 'Masukan nama yang benar!';
                              }
                              return null;
                            },
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
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong!';
                              }
                              if (value.length < 6) {
                                return 'Password harus lebih dari 6 karakter';
                              }
                              return null;
                            },
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
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (passwordTextController.text != value) {
                                return 'Password tidak sama!';
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
                                _signUp();
                              });
                            },
                            child: Text('Sign',
                                style: Theme.of(context).textTheme.bodyText1),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 6, 0),
                                child: Text('Sudah punya akun?',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              InkWell(
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('LogIn',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _signUp() async {
    try {
      _message = await authservice.signUp(
          name: fullNameController.text,
          email: emailTextController.text,
          password: passwordTextController.text,
          role: widget.signUpType);
    } catch (e) {
      print(e);
      if (mounted)
        setState(() {
          _message = e.toString();
          _loading = false;
        });
    }
  }
}
