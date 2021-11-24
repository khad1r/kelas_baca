import 'package:flutter/material.dart';
import 'package:kelas_baca/api/auth_service.dart';
import 'package:kelas_baca/api/service.dart';
import 'package:kelas_baca/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'navigation/app_router.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(KelasBaca());
}

class KelasBaca extends StatelessWidget {
  KelasBaca({Key? key}) : super(key: key);

  final Service _service = Service();

  @override
  Widget build(BuildContext context) {
    _service.init();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Service>(
            create: (context) => _service,
          ),
        ],
        child: MaterialApp(
          theme: ThemeApp.dark(),
          title: 'Kelas Baca',
          home: const Wrapper(),
        ));
  }
}
