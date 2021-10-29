import 'package:flutter/material.dart';
import 'package:kelas_baca/service/Listbook.dart';

class favBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 4.0 / 3.0;
    List<Widget> favList = new List();

    for (var i = 0; i < Books.length; i++) {
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
                    Image.asset(Books[i].imageurl, fit: BoxFit.cover),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          child: Text(Books[i].Title,
                              style: Theme.of(context).textTheme.headline3),
                        ))
                  ],
                ),
              ),
            )),
      );
      favList.add(favItem);
    }
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: favList,
    );
  }
}
