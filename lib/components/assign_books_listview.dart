import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/book_detail.dart';
import 'dart:math';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class AssignBooksListView extends StatefulWidget {
  final List<Book> assignbooks;
  var currentPage;

  AssignBooksListView({Key? key, required this.assignbooks}) : super(key: key) {
    this.currentPage = this.assignbooks.length - 1.0;
  }

  @override
  _AssignBooksListViewState createState() => new _AssignBooksListViewState();
}

class _AssignBooksListViewState extends State<AssignBooksListView> {
  // final PageController controller = PageController();
  var padding = 20.0;
  var verticalInset = 20.0;
  // @override
  // void initState() {
  //   super.initState();

  //   /// Attach a listener which will update the state and refresh the page index
  //   controller.addListener(() {
  //     setState(() {
  //       widget.currentPage = controller.page;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final List<Book> assignbooks = widget.assignbooks;
    PageController controller =
        PageController(initialPage: assignbooks.length - 1);
    controller.addListener(() {
      setState(() {
        widget.currentPage = controller.page;
      });
    });

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: widgetAspectRatio,
          child: LayoutBuilder(builder: (context, contraints) {
            var width = contraints.maxWidth;
            var height = contraints.maxHeight;

            var safeWidth = width - 2 * padding;
            var safeHeight = height - 2 * padding;

            var heightOfPrimaryCard = safeHeight;
            var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

            var primaryCardLeft = safeWidth - widthOfPrimaryCard;
            var horizontalInset = primaryCardLeft / 2.85;

            List<Widget> cardList = [];
            if (widget.assignbooks == [] || widget.assignbooks.length == 0) {
              return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: padding + verticalInset,
                      vertical: padding + verticalInset),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: Image.asset(
                                'assets/images/no_assign.png',
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
                              child: Text("Tidak Ada Buku Untuk dibaca",
                                  style: Theme.of(context).textTheme.headline3),
                            )),
                      )));
            } else {
              for (var i = 0; i < assignbooks.length; i++) {
                var delta = i - widget.currentPage;
                bool isOnRight = delta > 0;

                var start = padding +
                    max(
                        primaryCardLeft -
                            horizontalInset * -delta * (isOnRight ? 15 : 1),
                        1.0);

                var cardItem = Positioned.directional(
                  top: padding + verticalInset * max(-delta, -0.75),
                  bottom: padding + verticalInset * max(-delta, -0.75),
                  start: start,
                  textDirection: TextDirection.rtl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
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
                            Image.asset(assignbooks[i].imageurl,
                                fit: BoxFit.cover),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Text(assignbooks[i].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                cardList.add(cardItem);
              }
            }
            return Stack(
              children: cardList,
            );
          }),
        ),
        Positioned.fill(
          child: PageView.builder(
            itemCount: assignbooks.length,
            controller: controller,
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (widget.assignbooks == [] || widget.assignbooks.length == 0) {
                return Container();
              }
              return InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookDetail(book: widget.assignbooks[index]),
                      ),
                    );
                  },
                  child: Container());
            },
          ),
        )
      ],
    );
  }
}
