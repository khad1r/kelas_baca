import 'package:flutter/material.dart';
import 'package:kelas_baca/api/kelas_baca_services.dart';
import 'package:kelas_baca/components/components.dart';
import 'package:kelas_baca/models/models.dart';
import 'package:provider/provider.dart';
// import 'package:kelas_baca/widget/cards.dart';
// import 'package:kelas_baca/widget/favorite.dart';

class StudentHome extends StatefulWidget {
  StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  late StudentService studentService;
  List<Book> assignbooks = [];
  List<Book> favoritebooks = [];
  void didChangeDependencies() {
    final service = Provider.of<Service>(context).userService;
    if (service is StudentService) {
      studentService = service;
    }
    refresh();
    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future refresh() async {
    final abook = await studentService.getBooks();
    final fbook = await studentService.getFavoriteBooks();

    setState(() {
      assignbooks = abook;
      favoritebooks = fbook;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 30.0, bottom: 2.0),
            child: Center(
              child: Text("Buku Untuk Dibaca",
                  style: Theme.of(context).textTheme.headline2),
            ),
          ),
          AssignBooksListView(assignbooks: assignbooks),
          // FutureBuilder(
          //   future: studentService.getBooks(),
          //   builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       return AssignBooksListView(assignbooks: snapshot.data ?? []);
          //     } else {
          //       // 10
          //       return SizedBox(
          //         height: 500,
          //         child: const Center(child: CircularProgressIndicator()),
          //       );
          //     }
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 2.0, bottom: 20.0),
            child: Center(
              child: Text("Buku Favorit",
                  style: Theme.of(context).textTheme.headline2),
            ),
          ),
          FavoriteBooksListview(favoritebooks: favoritebooks),
          // FutureBuilder(
          //   future: studentService.getFavoriteBooks(),
          //   builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       return FavoriteBooksListview(
          //           favoritebooks: snapshot.data ?? []);
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
      ),
    );
  }
}
