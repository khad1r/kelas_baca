import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents Homepage for Navigation
class ReadBook extends StatefulWidget {
  Book book;
  ReadBook({Key? key, required this.book}) : super(key: key);
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<ReadBook> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late StudentService studentService;

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    studentService = Provider.of<Service>(context, listen: false).userService;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
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
        title: Text(widget.book.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.book.pdfurl,
        key: _pdfViewerKey,
      ),
    );
  }
}
