import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';

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
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('active_student')) {
          final idstudent = prefs.getString('active_student');
          if (idstudent != null) {
            _role = "Student";
            StudentService studentService =
                StudentService(studentID: idstudent);
            await studentService.InitService();
            userService = studentService;
          }
        } else
          userService = ParentService(parentID: id);
      }
      _isInitialized = true;
      auth.reload();
      _userData = UserApp.fromJson(await auth.userData);
    } else {
      _role = null;
      userService = null;
      _userData = null;
      _isInitialized = false;
    }
    notifyListeners();
  }

  bool didSelectUser = false;
  void tapOnProfile(bool selected) {
    didSelectUser = selected;
    notifyListeners();
  }
}
