import 'package:flutter/material.dart';

import 'profile_pic.dart';

class StudentTile extends StatelessWidget {
  final String name;
  final List<Widget> actions;

  const StudentTile(
      {Key? key, required this.name, this.actions: const <Widget>[]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0)
        ],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfilePicture(
            name: name,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name,
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: actions,
          )
        ],
      ),
    );
  }
}
