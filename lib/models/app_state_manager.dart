import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/api/service.dart';

class AppStateManager extends ChangeNotifier {
  Service service = Service();
  String? userRole;
  bool _loggedIn = false;
  bool _initialized = false;
  bool _onboardingComplete = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;

  void initializeApp() async {
    _loggedIn = await service.auth.getUser != null;
    if (_loggedIn) {
      await service.setUserService();
      userRole = await service.auth.getRole;
    }
    _initialized = true;
    notifyListeners();
  }

  void login({required String email, required String password}) async {
    await service.auth.signIn(email, password);
    initializeApp();
    notifyListeners();
  }

  void signUp(
      {required String name,
      required String email,
      required String password,
      required String role}) async {
    await service.auth.signUp(name, email, password, role);
    initializeApp();
    notifyListeners();
  }

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  void logout() async {
    _loggedIn = false;
    _initialized = false;
    userRole = null;
    await service.auth.signOut();
    initializeApp();
    notifyListeners();
  }
}
