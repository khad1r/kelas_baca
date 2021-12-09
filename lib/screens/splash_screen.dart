import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/kelas_baca_services.dart';
import '../models/models.dart';

class SplashScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: AppPages.splashPath,
      key: ValueKey(AppPages.splashPath),
      child: const SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Service>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
          child: Container(
        width: 150,
        // child: Image.asset('assets/images/splashicon.png'),
        child: CircularProgressIndicator(),
      )),
    );
  }
}
