import 'package:flutter/material.dart';
import 'package:kelas_baca/data.dart';
import 'package:kelas_baca/widget/cards.dart';
import 'package:kelas_baca/widget/favorite.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => new _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 50.0, bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("List Buku",
                        style: Theme.of(context).textTheme.headline1),
                  ],
                ),
              ),
              Stack(children: cardList(currentPage, controller)),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 2.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Favourite",
                        style: Theme.of(context).textTheme.headline1)
                  ],
                ),
              ),
              favBook(),
            ],
          ),
        ),
      ),
    );
  }
}
