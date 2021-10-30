import 'package:flutter/material.dart';
// import 'package:kelas_baca/service/Listbook.dart';
import '../screens/book_detail.dart';
import '../models/models.dart';

class FavoriteBooksListview extends StatelessWidget {
  final List<Book> favoritebooks;
  FavoriteBooksListview({Key? key, required this.favoritebooks})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 4.0 / 3.0;
    List<Widget> favList = [];

    if (this.favoritebooks == [] || this.favoritebooks.length == 0) {
      favList.add(Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 240,
              width: 320,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: Image.asset(
                      'assets/images/no_favorite.png',
                    ).image,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ]),
              child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Center(
                    child: Text("Tidak Ada Buku Favorit",
                        style: Theme.of(context).textTheme.headline3),
                  )),
            )),
      ));
    } else {
      for (var i = 0; i < favoritebooks.length; i++) {
        var favItem = Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookDetail(book: favoritebooks[i]),
                      ),
                    );
                  },
                  child: Container(
                    height: 240,
                    width: 320,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3.0, 6.0),
                          blurRadius: 10.0)
                    ]),
                    child: AspectRatio(
                      aspectRatio: cardAspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(favoritebooks[i].imageurl,
                              fit: BoxFit.cover),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                                child: Text(favoritebooks[i].title,
                                    style:
                                        Theme.of(context).textTheme.headline3),
                              ))
                        ],
                      ),
                    ),
                  )),
            ));
        favList.add(favItem);
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: favList,
    );
  }
}
