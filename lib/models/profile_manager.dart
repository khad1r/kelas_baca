import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelas_baca/api/auth_service.dart';

import 'models.dart';

class ProfileManager extends ChangeNotifier {
  Future<UserApp> get getUser async =>
      UserApp.fromJson(await AuthService.userData);

  bool get didSelectUser => _didSelectUser;
  bool get didTapOnRaywenderlich => _tapOnRaywenderlich;
  bool get darkMode => _darkMode;

  var _didSelectUser = false;
  var _tapOnRaywenderlich = false;
  var _darkMode = false;

  void set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnRaywenderlich(bool selected) {
    _tapOnRaywenderlich = selected;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
