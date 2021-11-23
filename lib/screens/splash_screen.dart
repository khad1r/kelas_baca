import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
            ),
            // const Image(
            //   height: 200,
            //   image: AssetImage('assets/image/rw_logo.png'),
            // ),
            const Text('Initializing...')
          ],
        ),
      ),
    );
  }
}
