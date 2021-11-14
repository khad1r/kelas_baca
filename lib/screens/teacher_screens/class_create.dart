import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/models.dart';

class ClassCreate extends StatefulWidget {
  // final Function(groceryItem) onCreate;
  final Function() onCreate;
  ClassCreate({
    Key? key,
    required this.onCreate,
  }) : super(key: key);

  @override
  _ClassCreateState createState() => _ClassCreateState();
}

class _ClassCreateState extends State<ClassCreate> {
  final _nameController = TextEditingController();
  String _name = '';

  @override
  void initState() {
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
              // // 1
              // final groceryItem = GroceryItem(
              //   id: widget.originalItem?.id ?? const Uuid().v1(),
              //   name: _nameController.text,
              //   importance: _importance,
              //   color: _currentColor,
              //   quantity: _currentSliderValue,
              //   date: DateTime(
              //     _dueDate.year,
              //     _dueDate.month,
              //     _dueDate.day,
              //     _timeOfDay.hour,
              //     _timeOfDay.minute,
              //   ),
              // );

              // widget.onCreate(groceryItem);
            },
          )
        ],
        title: Text(
          'Buat Kelas',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      // 5
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildNameField(),
            const SizedBox(height: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
              ),
              onPressed: () async {
                // // 1
                // final groceryItem = GroceryItem(
                //   id: widget.originalItem?.id ?? const Uuid().v1(),
                //   name: _nameController.text,
                //   importance: _importance,
                //   color: _currentColor,
                //   quantity: _currentSliderValue,
                //   date: DateTime(
                //     _dueDate.year,
                //     _dueDate.month,
                //     _dueDate.day,
                //     _timeOfDay.hour,
                //     _timeOfDay.minute,
                //   ),
                // );

                // widget.onCreate(groceryItem);
              },
              child: Text('Buat', style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    // 1
    return Column(
      // 2
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3
        Text(
          'Nama Kelas',
          style: Theme.of(context).textTheme.headline2,
        ),
        // 4
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            // 8
            hintText: 'Kelas 1',
            // 9
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            // focusedBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.blueAccent),
            // ),
            // border: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.blueAccent),
            // ),
          ),
        ),
      ],
    );
  }
}
