import 'package:flutter/material.dart';
import 'package:kelas_baca/api/service.dart';

import '../models/models.dart';
import '../screens/screens.dart';

// 1
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  // 2
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // 3
  final Service service;
  // 4
  // final GroceryManager groceryManager;
  // final ProfileManager profileManager;

  AppRouter({
    required this.service,
    // required this.groceryManager,
    // required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    service.addListener(notifyListeners);
    // groceryManager.addListener(notifyListeners);
    // profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    service.removeListener(notifyListeners);
    // groceryManager.removeListener(notifyListeners);
    // profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  // 5
  @override
  Widget build(BuildContext context) {
    // 6
    return Navigator(
      // 7
      key: navigatorKey,
      onPopPage: _handlePopPage,
      // 8
      pages: [
        // if (!appStateManager.isInitialized) SplashScreen.page(),
        if (!service.auth.isLoggedIn() && service.userService == null)
          LoginScreen.page(),
        if (service.auth.isLoggedIn() && service.getRole == "Parent")
          ParentMain.page(),
        if (service.auth.isLoggedIn() && service.getRole == "Teacher")
          TeacherMain.page(),
        // if (appStateManager.isOnboardingComplete)
        //   Home.page(appStateManager.getSelectedTab),
        // if (groceryManager.isCreatingNewItem)
        //   GroceryItemScreen.page(onCreate: (item) {
        //     groceryManager.addItem(item);
        //   }, onUpdate: (item, index) {
        //     // No update
        //   }),
        // // 1
        // if (groceryManager.selectedIndex != -1)
        //   // 2
        //   GroceryItemScreen.page(
        //       item: groceryManager.selectedGroceryItem,
        //       index: groceryManager.selectedIndex,
        //       onUpdate: (item, index) {
        //         // 3
        //         groceryManager.updateItem(item, index);
        //       },
        //       onCreate: (_) {
        //         // No create
        //       }),
        if (service.didSelectUser) ProfileScreen.page(),
        // if (profileManager.didTapOnRaywenderlich) WebViewScreen.page()
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == AppPages.profilePath) {
      service.tapOnProfile(false);
    }

    return true;
  }

  // 9
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
