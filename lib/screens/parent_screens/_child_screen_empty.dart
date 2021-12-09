import 'package:flutter/material.dart';

import 'parent_screens.dart';

class EmptyClass extends StatelessWidget {
  const EmptyClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Belum ada Kelas', style: Theme.of(context).textTheme.headline2),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            primary: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.orange, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
          ),
          child: const Text('Gabung dengan kelas'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChildSetting(),
              ),
            );
          },
        ),
      ],
    );
  }
}
