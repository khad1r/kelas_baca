import 'package:flutter/material.dart';
import './book_item_screen.dart';
import '../../models/models.dart';
import '../../api/mock_student_service.dart';
import '../../components/components.dart';
import './_class_setting.dart';
import 'announce_screen.dart';

// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  final mockService = MockStudentService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.blueAccent,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //             // 1
//             final manager = Provider.of<GroceryManager>(context, listen: false);
// // 2
              Navigator.push(
                context,
                // 3
                MaterialPageRoute(
                  // 4
                  builder: (context) => AnnouceScreen(
                    // 5
                    // onCreate: (item) {
                    onSave: () {
                      // // 6
                      // manager.addItem(item);
                      // // 7
                      // Navigator.pop(context);
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
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    primary: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        builder: (context) => ClassSetting(),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        "[Nama Kelas]",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Kelas #",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
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
                              FutureBuilder(
                                future: mockService.getAssignBooks(),
                                builder: (context,
                                    AsyncSnapshot<List<Book>> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    // final manager =
                                    //     Provider.of<GroceryManager>(context,
                                    //         listen: false);
                                    return ClassBookListView(
                                      books: snapshot.data ?? [],
                                      createFunc: () {
                                        Navigator.push(
                                          context,
                                          // 3
                                          MaterialPageRoute(
                                            // 4
                                            builder: (context) =>
                                                BookItemScreen(
                                              // 5
                                              onCreate: (book) {
                                                // 6
                                                // manager.addItem(book);
                                                // 7
                                                Navigator.pop(context);
                                              },
                                              // 8
                                              onUpdate: (book) {},
                                            ),
                                          ),
                                        );
                                      },
                                      updateFunc: (book) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookItemScreen(
                                                originalItem: book,
                                                // 3
                                                onUpdate: (book) {
                                                  // 4
                                                  // manager.updateItem(book, index);
                                                  // 5
                                                  Navigator.pop(context);
                                                },
                                                // 6
                                                onCreate: (book) {},
                                              ),
                                            ));
                                      },
                                    );
                                  } else {
                                    // 10
                                    return SizedBox(
                                      height: 300,
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                },
                              ),
                              Text(
                                "Siswa",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              _buildSearchCard(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 15, 5, 15),
                                child: ListView.separated(
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
                                    itemCount: students.length),
                              ),
                            ])))
              ],
            ),
          ])),
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
}

class mockStudent {
  String name;
  mockStudent({required this.name});
}
