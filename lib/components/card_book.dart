import 'package:flutter/material.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardBook extends StatelessWidget {
  final double aspectRatio;
  final Function? onTap;
  final Book book;
  const CardBook({
    Key? key,
    required this.book,
    this.aspectRatio: 12.0 / 16.0,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
              onTap: () async {
                onTap!(book);
              },
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      book.imageurl,
                      fit: BoxFit.cover,
                    ),
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
}
