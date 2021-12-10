import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_baca/screens/parent_screens/parent_screens.dart';
import 'package:provider/provider.dart';
import '../../api/kelas_baca_services.dart';
import '../../models/models.dart';

class BookDetail extends StatefulWidget {
  final Book book;
  BookDetail({Key? key, required this.book}) : super(key: key);
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late ChildService childService;
  void didChangeDependencies() {
    super.didChangeDependencies();
    childService =
        Provider.of<Service>(context, listen: false).userService.childDoc;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[900],
    ));
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue[900],
          body: FutureBuilder<DocumentSnapshot>(
              future: childService.getChildBook(widget.book.id),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                BookStudent? studentBook;
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.exists) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    studentBook = BookStudent(
                      id: snapshot.data!.id,
                      progress: data['progress'],
                    );
                  }
                  return ListView(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.book.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      if (studentBook != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Progress baca : ${studentBook.progress}/-',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios_new_rounded),
                                iconSize: 30,
                                color: Colors.grey,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Expanded(
                                child: Column(children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ActionButton(studentBook != null)),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReadBook(book: widget.book)),
                                    );
                                    // var snackBar = SnackBar(
                                    //     content:
                                    //         Text('Read ${widget.book.title}'));
                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(snackBar);
                                  },
                                  child: Text('Baca',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                              ),
                            ]))
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
                  );
                }

                return CircularProgressIndicator();
              })),
    );
  }

  Widget ActionButton(bool isAssign) {
    if (isAssign)
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          primary: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          childService.deleteFromList(widget.book.id);
          Navigator.of(context).pop();
        },
        child: Text('Hapus dari bacaan',
            style: Theme.of(context).textTheme.bodyText1),
      );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        childService.addToList(widget.book.id);
        Navigator.of(context).pop();
      },
      child: Text('Tambahkan ke bacaan',
          style: Theme.of(context).textTheme.bodyText1),
    );
  }
}
