import 'package:flutter/material.dart';
import 'package:kelas_baca/api/auth_service.dart';
import 'package:kelas_baca/api/service.dart';
import 'package:kelas_baca/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const KelasBaca());
}

class KelasBaca extends StatefulWidget {
  const KelasBaca({Key? key}) : super(key: key);

  @override
  State<KelasBaca> createState() => _KelasBacaState();
}

class _KelasBacaState extends State<KelasBaca> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Service>(
          create: (context) => Service(),
        ),
      ],
      child: Wrapper(),
    );
  }
}
