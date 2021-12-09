import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'api/kelas_baca_services.dart';
import 'navigation/app_router.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(KelasBaca());
}

class KelasBaca extends StatefulWidget {
  KelasBaca({Key? key}) : super(key: key);

  @override
  State<KelasBaca> createState() => _KelasBacaState();
}

class _KelasBacaState extends State<KelasBaca> {
  final Service _service = Service();

  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(service: _service);
    super.initState();
  }

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
          home: Router(
            routerDelegate: _appRouter,
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        ));
  }
}
