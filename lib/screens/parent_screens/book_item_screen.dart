import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_baca/components/components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nanoid/nanoid.dart';

import 'package:flutter/foundation.dart';
import '../../models/models.dart';

class BookItemScreen extends StatefulWidget {
  // // 1
  // final Function(GroceryItem) onCreate;
  // // 2
  // final Function(GroceryItem) onUpdate;
  // // 1
  final Function(BookRaw) onCreate;
  // 2
  final Function(BookRaw) onUpdate;

  final Function? onDelete;
  // 3
  final Book? originalItem;
  // 4
  final bool isUpdating;

  BookItemScreen(
      {Key? key,
      required this.onCreate,
      required this.onUpdate,
      this.originalItem,
      this.onDelete})
      : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _BookItemScreenState createState() => _BookItemScreenState();
}

class _BookItemScreenState extends State<BookItemScreen> {
  final _titleController = TextEditingController();
  final _discriptionController = TextEditingController();
  String imgUrl = '';
  String pdfUrl = '';
  String title = '';
  String description = '';
  bool imagePicked = false;
  bool pdfPicked = false;
  bool process = false;
  File? imagefile;
  File? pdffile;

  // Importance _importance = Importance.low;
  // DateTime _dueDate = DateTime.now();
  // TimeOfDay _timeOfDay = TimeOfDay.now();
  // Color _currentColor = Colors.green;
  // int _currentSliderValue = 0;

  @override
  void initState() {
    // 1
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _titleController.text = originalItem.title;
      _discriptionController.text = originalItem.description;
      imgUrl = originalItem.imageurl;
      pdfUrl = originalItem.pdfurl;
      title = originalItem.title;
      description = originalItem.description;
    }

    _titleController.addListener(() {
      setState(() {
        title = _titleController.text;
      });
    });

    _discriptionController.addListener(() {
      setState(() {
        description = _discriptionController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _discriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1
    return Scaffold(
      // 2
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
        actions: [ActionButton()],
        // 4
        title: Text(
          'Book',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      // 5
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 200,
              child: Row(
                children: [card(), Expanded(child: buildTitleField())],
              ),
            ),
            buildDescriptionField(),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: (pdffile != null || pdfUrl != '')
                    ? Colors.blue[800]
                    : Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
              ),
              onPressed: () async {
                _pickpdf();
              },
              child: Text('Upload Buku',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            SizedBox(height: 20),
            buildButton()
          ],
        ),
      ),
    );
  }

  Widget card() {
    var cardAspectRatio = 12.0 / 16.0;
    if (imagefile != null || imgUrl != '') {
      return Container(
          margin: EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: InkWell(
                onTap: () async {
                  _pickImage();
                },
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      if (imagePicked)
                        Image.file(imagefile!, fit: BoxFit.cover)
                      else
                        Image.network(imgUrl, fit: BoxFit.cover)
                    ],
                  ),
                )),
          ));
    }
    return AddCard(
        aspectRatio: cardAspectRatio,
        onTap: () {
          _pickImage();
        });
  }

  Widget buildTitleField() {
    // 1
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Judul',
            style: Theme.of(context).textTheme.headline1,
          ),
          TextField(
            // 5
            controller: _titleController,
            style: Theme.of(context).textTheme.headline2,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Judul Buku',
              // enabledBorder: const UnderlineInputBorder(
              //   borderSide: BorderSide(color: Colors.white),
              // ),
              // focusedBorder: UnderlineInputBorder(
              //   borderSide: BorderSide(color: Colors.white),
              // ),
              // border: UnderlineInputBorder(
              //   borderSide: BorderSide(color: Colors.white),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescriptionField() {
    // 1
    return Column(
      // 2
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 3
        Text(
          'Deskripsi',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        // 4
        TextField(
          controller: _discriptionController,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.justify,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'Deskripsi Buku',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Colors.blue[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 75, vertical: 20),
      ),
      onPressed: () {
        setState(() {
          process = true;
          saving();
        });
      },
      child: process
          ? CircularProgressIndicator()
          : Text('Simpan', style: Theme.of(context).textTheme.bodyText1),
    );
  }

  Widget ActionButton() {
    if (widget.isUpdating)
      return IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await widget.onDelete!();

          Navigator.pop(context);
        },
      );
    return IconButton(
      icon: const Icon(Icons.check),
      onPressed: () {
        setState(() {
          process = true;
          saving();
        });
      },
    );
  }

  saving() async {
    if (!widget.isUpdating) {
      BookRaw book = BookRaw(
          id: nanoid(),
          title: title,
          image: imagefile,
          pdf: pdffile,
          description: description);
      await widget.onCreate(book);
    } else {
      BookRaw book = BookRaw(
          id: widget.originalItem!.id,
          title: title,
          image: imagePicked ? await imagefile! : null,
          pdf: pdfPicked ? await pdffile! : null,
          description: description);
      await widget.onUpdate(book);
    }
    Navigator.pop(context);
  }

  _pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      imagefile = await File(result.files.single.path!);
      imagePicked = true;
      setState(() {});
    } else {
      return;
    }
  }

  _pickpdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );
    if (result != null) {
      pdffile = File(result.files.single.path!);
      pdfPicked = true;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }
}
