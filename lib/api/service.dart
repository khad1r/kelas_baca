import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kelas_baca/models/models.dart';

import 'auth_service.dart';
import 'firebase_parent_service.dart';
import 'firestore_teacher_service.dart';

class Service {
  AuthService auth = AuthService();
  var userService;
  String? role;
  UserApp? userData;

  init() async {
    auth.addListener(() {
      setService();
    });
    setService();
  }

  setService() async {
    if (auth.isLoggedIn()) {
      role = await auth.getRole;
      var id = await auth.getUser!.uid;
      if (role == "Teacher") {
        userService = TeacherService(teacherID: id);
      } else if (role == "Parent") {
        userService = ParentService(parentID: id);
      }
      auth.reload();
      userData = UserApp.fromJson(await auth.userData);
    } else {
      role = null;
      userService = null;
      userData = null;
    }
  }
}
