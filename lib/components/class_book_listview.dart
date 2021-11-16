import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class ClassBookListView extends StatelessWidget {
  final Function(Book) updateFunc;
  // 2
  final Function() createFunc;
  final List<Book> books;
  ClassBookListView(
      {Key? key,
      required this.books,
      required this.createFunc,
      required this.updateFunc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Books',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 16),
        Container(
          height: 300,
          color: Colors.transparent,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                for (var i = 0; i < books.length; i++)
                  _cardBuild(context, books[i]),
                _cardAdd(),
              ]),
        )
      ],
    );
  }

  Widget _cardBuild(BuildContext context, Book book) {
    var cardAspectRatio = 12.0 / 16.0;
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
              onTap: () async {
                updateFunc(book);
              },
              child: AspectRatio(
                aspectRatio: cardAspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(book.imageurl, fit: BoxFit.cover),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Text(book.title,
                              style: Theme.of(context).textTheme.headline3),
                        ))
                  ],
                ),
              )),
        ));
  }

  Widget _cardAdd() {
    var cardAspectRatio = 12.0 / 16.0;
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
              onTap: () async {
                createFunc();
              },
              child: AspectRatio(
                aspectRatio: cardAspectRatio,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      // image: DecorationImage(
                      //   fit: BoxFit.fitWidth,
                      //   image: Image.asset(
                      //     'assets/images/no_favorite.png',
                      //   ).image,
                      // ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(3.0, 6.0),
                            blurRadius: 10.0)
                      ]),
                  child: Center(
                      child: IconButton(
                    onPressed: () {
                      createFunc();
                    },
                    icon: Icon(Icons.add_circle_outline),
                    iconSize: 60.0,
                    color: Colors.white.withOpacity(0.5),
                  )),
                ),
              ))),
    );
  }
}
