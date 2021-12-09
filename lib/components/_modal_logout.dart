import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/kelas_baca_services.dart';

class ModalLogout extends StatefulWidget {
  const ModalLogout({
    Key? key,
  }) : super(key: key);

  @override
  State<ModalLogout> createState() => _ModalLogoutState();
}

class _ModalLogoutState extends State<ModalLogout> {
  TextEditingController passwordTextController = TextEditingController();
  bool passwordVisibility = false;
  String? _message;
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Service service;
  late StudentService studentService;

  void didChangeDependencies() {
    super.didChangeDependencies();
    service = Provider.of<Service>(context, listen: false);
    studentService = service.userService;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login Orang Tua',
                style: Theme.of(context).textTheme.headline3),
            Padding(
              padding: EdgeInsets.all(25),
              child: _loading
                  ? CircularProgressIndicator()
                  : Text('${_message ?? ''}',
                      style: Theme.of(context).textTheme.bodyText1),
            ),
            _buildInput(
              textController: passwordTextController,
              label: 'Password Orang Tua',
              keyboardType: TextInputType.visiblePassword,
              hint: 'Masukan Password...',
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
              child:
                  Text('Login', style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    try {
      _message = await service.auth
          .logOutStudent(password: passwordTextController.text);
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
