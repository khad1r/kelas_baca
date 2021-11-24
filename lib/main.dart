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
  Service _service = Service();
  @override
  Widget build(BuildContext context) {
    _service.init();
    return MultiProvider(
      providers: [
        Provider<Service>(
          create: (context) => _service,
        ),
      ],
      child: const Wrapper(),
    );
  }
}
