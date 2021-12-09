import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  final double aspectRatio;
  final Function? onTap;
  const AddCard({
    Key? key,
    this.aspectRatio: 12.0 / 16.0,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ]),
              child: Center(
                  child: IconButton(
                onPressed: () {
                  onTap!();
                },
                icon: Icon(Icons.add_circle_outline),
                iconSize: 60.0,
                color: Colors.white.withOpacity(0.5),
              )),
            ),
          )),
    );
  }
}
