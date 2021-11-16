import 'package:flutter/material.dart';
import 'package:kelas_baca/api/firebase_services.dart';
import 'package:kelas_baca/api/service.dart';
import 'package:provider/provider.dart';
import './book_item_screen.dart';
import '../../models/models.dart';
import '../../api/mock_student_service.dart';
import '../../components/components.dart';
import './_class_setting.dart';
import 'announce_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  final mockService = MockStudentService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var classService;
  late TextEditingController searchTextController;
  List<mockStudent> students = [
    mockStudent(name: "Putra Siyang"),
    mockStudent(name: "Putri Tidur"),
    mockStudent(name: "Ananda Sore"),
    mockStudent(name: "Putra Siyang"),
    mockStudent(name: "Putri Tidur"),
    mockStudent(name: "Ananda Sore"),
    mockStudent(name: "Putra Siyang"),
    mockStudent(name: "Putri Tidur"),
    mockStudent(name: "Ananda Sore"),
    mockStudent(name: "Putra Siyang"),
    mockStudent(name: "Putri Tidur"),
    mockStudent(name: "Ananda Sore"),
    mockStudent(name: "Putra Siyang"),
    mockStudent(name: "Putri Tidur"),
    mockStudent(name: "Abdul Kadir Jaelani"),
  ];

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    classService =
        Provider.of<Service>(context, listen: false).userService.classDoc;
    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
          stream: classService.getClass(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Scaffold(
                  key: scaffoldKey,
                  backgroundColor: Colors.blueAccent,
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        // 3
                        MaterialPageRoute(
                          // 4
                          builder: (context) => AnnouceScreen(
                            annoucement: data['Annoucement'],
                            onSave: (annoucement) {
                              classService.setClassAnnouc(annoucement);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                    backgroundColor: Colors.blueAccent,
                    elevation: 8,
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  body: Stack(fit: StackFit.expand, children: [
                    Positioned(
                      left: 0,
                      top: 10,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            classService = null;
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                          ),
                          child: Icon(Icons.arrow_back)),
                    ),
                    Positioned(
                      right: 0,
                      top: 10,
                      child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClassSetting(
                                  className: data['name'],
                                  classCode: classService.getClassId(),
                                  onDelete: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    classService.deleteClass();
                                  },
                                  onNameChange: (newName) {
                                    classService.updateClassName(newName);
                                  },
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                          ),
                          child: Icon(Icons.menu)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data['name'],
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(35, 35, 35, 0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50.0),
                                        topRight: Radius.circular(50.0))),
                                child: ListView(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    physics: BouncingScrollPhysics(),
                                    children: [
                                      _buildBooksView(),
                                      Text(
                                        "Siswa",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      _buildSearchCard(),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 15, 5, 15),
                                          child: _buildStudentView()),
                                    ])))
                      ],
                    ),
                  ]));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildBooksView() {
    return StreamBuilder<QuerySnapshot>(
      stream: classService.getBooks(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        List<Book> books = snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return Book(
              id: data['id'],
              title: data['title'],
              imageurl: data['image'],
              pdfurl: data['pdf'],
              description: data['description']);
        }).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Books',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              color: Colors.transparent,
              child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    for (var i = 0; i < books.length; i++)
                      CardBook(
                        book: books[i],
                        onTap: (book) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookItemScreen(
                                    originalItem: book,
                                    // 3
                                    onUpdate: (book) async {
                                      await classService.updateBook(book);
                                    },
                                    // 6
                                    onCreate: (book) {},
                                    onDelete: () async {
                                      await classService
                                          .deleteBook(books[i].id);
                                    }),
                              ));
                        },
                      ),
                    AddCard(onTap: () {
                      Navigator.push(
                        context,
                        // 3
                        MaterialPageRoute(
                          // 4
                          builder: (context) => BookItemScreen(
                            // 5
                            onCreate: (book) async {
                              await classService.addBook(book);
                            },
                            // 8
                            onUpdate: (book) {},
                          ),
                        ),
                      );
                    }),
                  ]),
            )
          ],
        );
      },
    );
  }

  Widget _buildSearchCard() {
    return Card(
      color: Colors.blueAccent,
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // startSearch(searchTextController.text);
                // final currentFocus = FocusScope.of(context);
                // if (!currentFocus.hasPrimaryFocus) {
                //   currentFocus.unfocus();
                // }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
                child: TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Search'),
              autofocus: false,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                // if (!previousSearches.contains(value)) {
                //   previousSearches.add(value);
                //   savePreviousSearches();
                // }
              },
              controller: searchTextController,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentView() {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final student = students[index];
          return InkWell(
            onTap: () async {
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => StudentApp(),
              //   ),
              // );
            },
            child: StudentTile(
              name: student.name,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 13.5);
        },
        itemCount: students.length);
  }
}

class mockStudent {
  String name;
  mockStudent({required this.name});
}
