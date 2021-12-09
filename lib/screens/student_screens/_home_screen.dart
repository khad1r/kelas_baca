import 'package:flutter/material.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/components/components.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:kelas_baca/api/mock_student_service.dart';
import 'package:provider/provider.dart';
// import 'package:kelas_baca/widget/cards.dart';
// import 'package:kelas_baca/widget/favorite.dart';

class StudentHome extends StatefulWidget {
  StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final mockService = MockStudentService();
  late StudentService studentService;
  void didChangeDependencies() {
    super.didChangeDependencies();
    studentService = Provider.of<Service>(context, listen: false).userService;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 30.0, bottom: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Buku Untuk Dibaca",
                  style: Theme.of(context).textTheme.headline2),
            ],
          ),
        ),
        FutureBuilder(
          future: studentService.getBooks(),
          builder: (context, AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AssignBooksListView(assignbooks: snapshot.data ?? []);
            } else {
              // 10
              return SizedBox(
                height: 500,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 2.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Buku Favorit", style: Theme.of(context).textTheme.headline2)
            ],
          ),
        ),
        // FutureBuilder(
        //   future: mockService.getFavoriteBooks(),
        //   builder: (context, AsyncSnapshot<List<Book>> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return FavoriteBooksListview(favoritebooks: snapshot.data ?? []);
        //     } else {
        //       // 10
        //       return SizedBox(
        //         height: 200,
        //         child: const Center(child: CircularProgressIndicator()),
        //       );
        //     }
        //   },
        // ),
      ],
    );
  }
}
