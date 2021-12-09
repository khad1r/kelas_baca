import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../api/kelas_baca_services.dart';
import '../../components/components.dart';
import '../../models/models.dart';
import 'parent_screens.dart';

class ChildScreenHome extends StatefulWidget {
  ChildScreenHome({Key? key}) : super(key: key);

  @override
  _ChildScreenHomeState createState() => _ChildScreenHomeState();
}

class _ChildScreenHomeState extends State<ChildScreenHome> {
  late ChildService childService;

  void didChangeDependencies() {
    super.didChangeDependencies();
    childService =
        Provider.of<Service>(context, listen: false).userService.childDoc;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            'Buku dari kelas',
            style: Theme.of(context).textTheme.headline1,
          ),

          const SizedBox(height: 16),
          _buildClassBooksView(),
          // Text(
          //   "Siswa",
          //   style: Theme.of(context)
          //       .textTheme
          //       .headline1,
          // ),
          // _buildSearchCard(),
          // Padding(
          //     padding: const EdgeInsets.fromLTRB(
          //         5, 15, 5, 15),
          //     child: _buildStudentView()),
        ]);
  }

  Widget _buildClassBooksView() {
    return StreamBuilder<QuerySnapshot>(
        stream: childService.getBooks(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List<Book> books =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Book(
                id: data['id'],
                title: data['title'],
                imageurl: data['image'],
                pdfurl: data['pdf'],
                description: data['description']);
          }).toList();
          return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetail(
                            book: books[index],
                          ),
                        ),
                      );
                    },
                    child: BookTile(
                      book: books[index],
                    ));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 13.5);
              },
              itemCount: books.length);
        });
  }
}
