import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kelas_baca/models/models.dart';

import 'auth_service.dart';
import 'firebase_parent_service.dart';
import 'firestore_teacher_service.dart';

class Service extends ChangeNotifier {
  AuthService auth = AuthService();
  var userService;
  String? _role;
  UserApp? _userData;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  String? get getRole => _role;
  UserApp? get getUserData => _userData;

  init() async {
    auth.addListener(() {
      setService();
    });
    await setService();
    _isInitialized = true;
  }

  setService() async {
    if (auth.isLoggedIn()) {
      _role = await auth.getRole;
      var id = await auth.getUser!.uid;
      if (_role == "Teacher") {
        userService = TeacherService(teacherID: id);
      } else if (_role == "Parent") {
        userService = ParentService(parentID: id);
      }
      auth.reload();
      _userData = UserApp.fromJson(await auth.userData);
    } else {
      _role = null;
      userService = null;
      _userData = null;
      // _isInitialized = false;
    }
    notifyListeners();
  }

  bool didSelectUser = false;
  void tapOnProfile(bool selected) {
    didSelectUser = selected;
    notifyListeners();
  }
}
