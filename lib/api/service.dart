import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_service.dart';
import 'firestore_teacher_service.dart';

class Service {
  AuthService auth = AuthService();
  var userService;
  teacher(String id) {
    userService = TeacherService(teacherID: id);
  }
}
