import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'auth_service.dart';
import 'firebase_parent_service.dart';
import 'firestore_teacher_service.dart';

class Service {
  AuthService auth = AuthService();
  var userService;

  initService() async {
    if (auth.isLoggedIn()) {
      var role = await auth.getRole;
      var id = await auth.getUser!.uid;
      if (role == "Teacher") {
        userService = TeacherService(teacherID: id);
      } else if (role == "Parent") {
        userService = ParentService(parentID: id);
      }
      ;
    }
  }
}
