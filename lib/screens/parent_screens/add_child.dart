import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/models.dart';

class AddChild extends StatefulWidget {
  // final Function(groceryItem) onCreate;
  final Function(String, String) onCreate;
  AddChild({
    Key? key,
    required this.onCreate,
  }) : super(key: key);

  @override
  _AddChildState createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _name = '';
  String _age = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    _ageController.addListener(() {
      setState(() {
        _age = _ageController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
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
              widget.onCreate(_name, _age);
            },
          )
        ],
        title: Text(
          'Tambahkan Anak',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      // 5
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildNameField(),
              const SizedBox(height: 10.0),
              _buildAgeField(),
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
                  if (!_formKey.currentState!.validate()) return;
                  widget.onCreate(_name, _age);
                },
                child: Text('Tambah',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _nameController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Nama',
            labelStyle: Theme.of(context).textTheme.bodyText1,
            hintText: 'Masukan nama...',
            hintStyle: Theme.of(context).textTheme.bodyText1,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.blueGrey.withOpacity(0.5),
          ),
          validator: (String? value) {
            if (value!.isEmpty ||
                !RegExp(r"^[a-z A-Z]+$").hasMatch(value) ||
                value.length < 2) {
              return 'Masukan nama yang benar!';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAgeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _ageController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Umur',
            labelStyle: Theme.of(context).textTheme.bodyText1,
            hintText: 'Masukan umur...',
            hintStyle: Theme.of(context).textTheme.bodyText1,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.blueGrey.withOpacity(0.5),
          ),
          validator: (String? value) {
            if (value!.isEmpty || int.parse(value) < 1) {
              return 'Masukan Umur yang benar!';
            }
            return null;
          },
        ),
      ],
    );
  }
}
