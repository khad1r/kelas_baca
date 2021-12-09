import 'package:flutter/material.dart';
import 'package:string_to_hex/string_to_hex.dart';

class ProfilePicture extends StatelessWidget {
  final String name;
  const ProfilePicture({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final color;
    try {
      color = StringToHex.toColor(name);
    } catch (e) {
      color = int.parse('0xFF8687AA');
    }
    return CircleAvatar(
      backgroundColor: Color(color),
      child: Text(
        getInitials(name),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  String getInitials(String fullName) => fullName.isNotEmpty
      ? fullName.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
}
