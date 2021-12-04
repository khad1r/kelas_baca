import 'package:flutter/material.dart';
import 'package:kelas_baca/models/models.dart';

import 'card_book.dart';

class BookTile extends StatelessWidget {
  Book book;
  BookTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0)
        ],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 150,
              child: CardBook(
                book: book,
                useTitle: false,
              )),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(book.title,
                      style: Theme.of(context).textTheme.headline2),
                  Text(book.description,
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
