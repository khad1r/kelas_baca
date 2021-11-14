import 'package:flutter/material.dart';

class ClassSetting extends StatefulWidget {
  const ClassSetting({Key? key}) : super(key: key);

  @override
  State<ClassSetting> createState() => _ClassSettingState();
}

class _ClassSettingState extends State<ClassSetting> {
  TextEditingController classNameTextController =
      TextEditingController(text: '[Nama Kelas]');

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        scrollDirection: Axis.vertical,
        children: [
          Text("Detail Kelas", style: Theme.of(context).textTheme.headline1),
          SizedBox(height: 30),
          TextField(
            controller: classNameTextController,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white30,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.blueAccent.withOpacity(0.5),
              filled: true,
              hintText: "Nama Kelas",
              hintStyle: TextStyle(color: Colors.white30),
              prefixIcon:
                  Icon(Icons.people_alt, color: Colors.white, size: 26.0),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            initialValue: "[Kode Kelas]",
            readOnly: false,
            style: TextStyle(color: Colors.white30),
            cursorColor: Colors.white30,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.blueAccent.withOpacity(0.5),
              filled: true,
              hintText: "Kode Kelas",
              hintStyle: TextStyle(color: Colors.white30),
              prefixIcon:
                  Icon(Icons.vpn_key, color: Colors.white30, size: 26.0),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
              ),
              onPressed: () async {
                //TODO
              },
              child: Text('Hapus Kelas', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
