import 'package:flutter/material.dart';
// import 'package:kelas_baca/service/Listbook.dart';
import '../models/models.dart';

class FavoriteBooksListview extends StatelessWidget {
  final List<Book> favoritebooks;
  FavoriteBooksListview({Key? key, required this.favoritebooks})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 4.0 / 3.0;
    List<Widget> favList = [];

    for (var i = 0; i < favoritebooks.length; i++) {
      var favItem = Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 240,
              width: 320,
              child: AspectRatio(
                aspectRatio: cardAspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(favoritebooks[i].imageurl, fit: BoxFit.cover),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Text(favoritebooks[i].title,
                              style: Theme.of(context).textTheme.headline3),
                        ))
                  ],
                ),
              ),
            )),
      );
      favList.add(favItem);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: favList,
    );
  }
}
