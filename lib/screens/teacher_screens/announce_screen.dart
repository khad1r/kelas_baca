import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/models.dart';

class AnnouceScreen extends StatefulWidget {
  // final Function(groceryItem) onCreate;
  final Function(String) onSave;
  String annoucement;
  AnnouceScreen({
    Key? key,
    required this.annoucement,
    required this.onSave,
  }) : super(key: key);

  @override
  _AnnouceScreenState createState() => _AnnouceScreenState();
}

class _AnnouceScreenState extends State<AnnouceScreen> {
  final _TextController = TextEditingController();
  String annoucement = '';

  @override
  void initState() {
    annoucement = widget.annoucement;
    _TextController.text = widget.annoucement;
    _TextController.addListener(() {
      setState(() {
        annoucement = _TextController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _TextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 75,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.blueAccent,
          statusBarColor: Colors.blueAccent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.blueAccent,
          //Navigation bar divider color
          systemNavigationBarIconBrightness:
              Brightness.dark, //navigation bar icon
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              widget.onSave(annoucement);
            },
          )
        ],
        title: Text(
          'Pengumuman',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      // 5
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildTextField(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField() {
    // 1
    return Column(
      // 2
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3
        Text(
          'Pengumuman',
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(height: 25),
        // 4
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _TextController,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
