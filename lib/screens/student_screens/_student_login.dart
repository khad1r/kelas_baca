import 'package:flutter/material.dart';
import '../../components/components.dart';
import '../student_main.dart';

class StudentLogin extends StatelessWidget {
  StudentLogin({Key? key}) : super(key: key);
  List<mockStudent> students = [
    mockStudent(name: "Putra Siyang"),
    mockStudent(name: "Putri Tidur"),
    mockStudent(name: "Ananda Sore"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                // decoration: BoxDecoration(
                //   color: Colors.white,
                // ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Kelas Baca",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w800,
                              fontSize: 50)),
                      Text("Student",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w800,
                              fontSize: 20)),
                    ])),
            Container(
              padding: EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentApp(),
                          ),
                        );
                      },
                      child: StudentTile(
                        name: student.name,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: students.length),
            )
          ],
        ));
  }
}

class mockStudent {
  String name;
  mockStudent({required this.name});
}
