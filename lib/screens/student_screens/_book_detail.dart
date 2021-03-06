import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../api/kelas_baca_services.dart';
import '../../models/models.dart';
import 'student_screens.dart';

class BookDetail extends StatefulWidget {
  final Book book;
  BookDetail({Key? key, required this.book}) : super(key: key);
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  bool _isFavorited = false;
  late StudentService studentService;
  void didChangeDependencies() {
    super.didChangeDependencies();
    studentService = Provider.of<Service>(context, listen: false).userService;
    _isFavorited = studentService.isFavorited(widget.book.id);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[900],
    ));
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue[900],
          body: ListView(
            padding: EdgeInsets.all(20),
            scrollDirection: Axis.vertical,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  constraints: const BoxConstraints.expand(
                    width: 350,
                    height: 450,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.book.imageurl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.book.title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      iconSize: 30,
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 75, vertical: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReadBook(book: widget.book)),
                          );

                          // var snackBar = SnackBar(
                          //     content: Text('Read ${widget.book.title}'));
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text('Baca',
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    IconButton(
                      icon: Icon(_isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border),
                      iconSize: 30,
                      color: Colors.red[400],
                      onPressed: setFavorite,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.book.description,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          )),
    );
  }

  setFavorite() {
    _isFavorited
        ? studentService.removeFavorite(widget.book.id)
        : studentService.addFavorite(widget.book.id);
    setState(() {
      _isFavorited = studentService.isFavorited(widget.book.id);
    });
  }
}
