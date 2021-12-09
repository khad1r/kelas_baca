import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../api/kelas_baca_services.dart';
import '../../models/models.dart';

class ChildSetting extends StatefulWidget {
  // // String className;
  // String classCode;
  // Function() onDelete;
  // Function(String) onClassChange;
  // ChildSetting(
  //     {Key? key,
  //     required this.classCode,
  //     // required this.className,
  //     required this.onDelete,
  //     required this.onClassChange})
  //     : super(key: key);

  @override
  State<ChildSetting> createState() => _ChildSettingState();
}

class _ChildSettingState extends State<ChildSetting> {
  late ChildService childService;
  String classCode = '';
  TextEditingController classCodeTextController = TextEditingController();

  @override
  void initState() {
    classCodeTextController.addListener(() {
      setState(() {
        classCode = classCodeTextController.text;
      });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final service = Provider.of<Service>(context).userService;
    if (service is ParentService && service.childDoc != null) {
      childService = service.childDoc!;
    }

    classCode = childService.classId;
    setState(() {
      classCodeTextController.text = classCode;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    classCodeTextController.dispose();
    super.dispose();
  }

  @override
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
          Text('Detail', style: Theme.of(context).textTheme.headline1),
          SizedBox(height: 30),
          TextField(
            controller: classCodeTextController,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white30,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.blueAccent.withOpacity(0.5),
              filled: true,
              hintText: 'Kode Kelas',
              hintStyle: TextStyle(color: Colors.white30),
              prefixIcon:
                  Icon(Icons.people_alt, color: Colors.white, size: 26.0),
            ),
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
            onPressed: () async {
              var message = await childService.setClass(classCode);
              Navigator.popUntil(
                  context, ModalRoute.withName(AppPages.parentHome));
            },
            child: Text((childService.classId == '') ? 'Gabung' : 'Ganti',
                style: TextStyle(color: Colors.orange)),
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                primary: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
              ),
              onPressed: (childService.classId != '')
                  ? () async {
                      await Provider.of<Service>(context, listen: false)
                          .auth
                          .logInStudent(id: childService.getId);
                    }
                  : null,
              child: Text('Masuk Sebagai Murid',
                  style: TextStyle(color: Colors.blue)),
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
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title:
                      const Text('Apakah kamu yakin ingin menghapus Anak ini?'),
                  content: const Text(
                      'Anak yang sudah dihapus tidak dapat dikembalikan'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        childService.delete();
                        Navigator.popUntil(
                            context, ModalRoute.withName(AppPages.parentHome));
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: Text('Hapus Anak', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
