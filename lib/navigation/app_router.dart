import 'package:flutter/material.dart';
import '../api/kelas_baca_services.dart';

import '../screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final Service service;

  AppRouter({
    required this.service,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    service.addListener(notifyListeners);
  }

  @override
  void dispose() {
    service.removeListener(notifyListeners);
    super.dispose();
  }

  // @override
  // Future<bool> popRoute() async {
  //   return false; //if true the app will never exit. Otherwise, if you are on the rootpage the app will exit
  // }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!service.isInitialized) SplashScreen.page(),
        if (!service.auth.isLoggedIn() && service.userService == null)
          LoginScreen.page(),
        if (service.auth.isLoggedIn() && service.getRole == 'Parent')
          ParentMain.page(),
        if (service.auth.isLoggedIn() && service.getRole == 'Teacher')
          TeacherMain.page(),
        if (service.auth.isLoggedIn() && service.getRole == 'Student')
          StudentMain.page(),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    return true;
  }

  // 9
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
