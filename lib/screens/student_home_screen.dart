import 'package:flutter/material.dart';
import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_student_service.dart';
// import 'package:kelas_baca/widget/cards.dart';
// import 'package:kelas_baca/widget/favorite.dart';

class StudentHome extends StatelessWidget {
  final mockService = MockStudentService();

  StudentHome({Key? key}) : super(key: key);

  // var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getStudentHomeData(),
      builder: (context, AsyncSnapshot<StudentHomeData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 50.0, bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Buku Untuk Dibaca",
                        style: Theme.of(context).textTheme.headline2),
                  ],
                ),
              ),
              AssignBooksListView(
                  assignbooks: snapshot.data?.assignBooks ?? []),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 2.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Buku Favorit",
                        style: Theme.of(context).textTheme.headline2)
                  ],
                ),
              ),
              FavoriteBooksListview(
                  favoritebooks: snapshot.data?.favoriteBooks ?? [])
            ],
          );
        } else {
          // 10
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
