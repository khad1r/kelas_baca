import 'package:flutter/material.dart';
import 'package:string_to_hex/string_to_hex.dart';

class ProfilePicture extends StatelessWidget {
  final String name;
  const ProfilePicture({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(StringToHex.toColor(name)),
      child: Text(getInitials(name)),
    );
  }

  String getInitials(String fullName) => fullName.isNotEmpty
      ? fullName.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';
}
