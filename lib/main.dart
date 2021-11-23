import 'package:flutter/material.dart';
import 'package:kelas_baca/api/auth_service.dart';
import 'package:kelas_baca/api/service.dart';
import 'package:kelas_baca/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/models.dart';
import 'navigation/app_router.dart';
import 'theme.dart';

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
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;
  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      // groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        )
      ],
      child: MaterialApp(
        theme: ThemeApp.dark(),
        title: 'Kelas Baca',
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
