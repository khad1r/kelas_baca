import 'package:flutter/material.dart';
import 'dart:math';
import '../components/components.dart';
import '../models/models.dart';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class CardScrollWidget extends StatefulWidget {
  final List<Book> assignbooks;

  CardScrollWidget({Key? key, required this.assignbooks}) : super(key: key);

  @override
  _CardScrollWidgetState createState() => new _CardScrollWidgetState();
}

class _CardScrollWidgetState extends State<CardScrollWidget> {
  var currentPage = 0.0;
  var padding = 20.0;
  var verticalInset = 20.0;
  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < Books.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
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
                      Image.asset(Books[i].imageurl, fit: BoxFit.cover),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(Books[i].Title,
                                style: Theme.of(context).textTheme.headline2),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}

List<Widget> cardList(currentPage, controller) {
  return <Widget>[
    CardScrollWidget(currentPage),
    Positioned.fill(
      child: PageView.builder(
        itemCount: Books.length,
        controller: controller,
        reverse: true,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    )
  ];
}
