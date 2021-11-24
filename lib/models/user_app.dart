class UserApp {
  final String Name;
  final String role;

  UserApp({
    required this.Name,
    required this.role,
  });
  factory UserApp.fromJson(Map<dynamic, dynamic> json) =>
      UserApp(Name: json["name"] as String, role: json["role"] as String);
}
