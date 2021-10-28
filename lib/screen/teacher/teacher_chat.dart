import 'package:flutter/material.dart';

class teacherChat extends StatelessWidget {
  // 1
  final String category = 'Editor\'s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ray Wenderlich';

  // 2
  @override
  Widget build(BuildContext context) {
    // 3
    return Center(
      child: Container(
        child: Stack(
          children: [
            // 8
            Text(
              category,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            // 9
            Positioned(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline2,
              ),
              top: 20,
            ),
            // 10
            Positioned(
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              bottom: 30,
              right: 0,
            ),
            // 11
            Positioned(
              child: Text(
                chef,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              bottom: 10,
              right: 0,
            )
          ],
        ),
        // 1
        padding: const EdgeInsets.all(16),
        // 2
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        // 3
        decoration: const BoxDecoration(
          // 4
          image: DecorationImage(
            // 5
            image: AssetImage('assets/image_03.jpg'),
            // 6
            fit: BoxFit.cover,
          ),
          // 7
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
