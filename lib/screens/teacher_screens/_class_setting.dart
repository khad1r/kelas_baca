import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClassSetting extends StatefulWidget {
  String className;
  String classCode;
  Function() onDelete;
  Function(String) onNameChange;
  ClassSetting(
      {Key? key,
      required this.classCode,
      required this.className,
      required this.onDelete,
      required this.onNameChange})
      : super(key: key);

  @override
  State<ClassSetting> createState() => _ClassSettingState();
}

class _ClassSettingState extends State<ClassSetting> {
  String className = '[Nama Kelas]';
  TextEditingController classNameTextController = TextEditingController();

  @override
  void initState() {
    className = widget.className;
    classNameTextController.text = className;
    classNameTextController.addListener(() {
      setState(() {
        className = classNameTextController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    classNameTextController.dispose();
    super.dispose();
  }

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
                suffixIcon: InkWell(
                  onTap: widget.onNameChange(className),
                  child: Icon(
                    Icons.check,
                    color: Color(0x80FFFFFF),
                    size: 22,
                  ),
                )),
          ),
          SizedBox(height: 30),
          TextFormField(
            initialValue: widget.classCode,
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
                suffixIcon: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: widget.classCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${widget.classCode} Copied')));
                  },
                  child: Icon(
                    Icons.copy,
                    color: Color(0x80FFFFFF),
                    size: 22,
                  ),
                )),
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
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text(
                      'Apakah kamu yakin ingin menghapus Kelas ini?'),
                  content: const Text(
                      'Kelas yang sudah dihapus tidak dapat dikembalikan'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onDelete();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: Text('Hapus Kelas', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
