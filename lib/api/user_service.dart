import 'package:kelas_baca/api/firestore_teacher_service.dart';

class UserService {
  late UserService userService;
  teacher(String id) {
    userService = TeacherService(teacherID: id);
  }
}
