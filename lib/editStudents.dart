import 'package:assignment8/api.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';
import 'editCourses.dart';

class editStudents extends StatefulWidget {
  final String id;
  final String fname;
  final String lname;
  final String studentID;
  final String dateEntered;

  final CourseApi api = CourseApi();

  editStudents(
      this.id, this.fname, this.lname, this.studentID, this.dateEntered);

  @override
  _editStudentsState createState() =>
      _editStudentsState(id, fname, lname, studentID, dateEntered);
}

class _editStudentsState extends State<editStudents> {
  final String id;
  final String fname;
  final String lname;
  final String studentID;
  final String dateEntered;

  @override
  List students = [];
  bool _dbloaded = false;

  _editStudentsState(
      this.id, this.fname, this.lname, this.studentID, this.dateEntered);

  void initState() {
    super.initState();

    widget.api.getAllStudents().then((data) {
      setState(() {
        students = data;
        _dbloaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class App"),
      ),
      body: Center(
          child: _dbloaded
              ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            ...students
                                .map<Widget>(
                                  (students) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    editStudents(
                                                        students['_id'],
                                                        students['fname'],
                                                        students['lname'],
                                                        students['studentID']
                                                            .toString(),
                                                        students['dateEntered']
                                                            .toString()))),
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 30,
                                          child: Text(students['courseID']),
                                        ),
                                        title: Text(
                                          (students['fname'] +
                                              ['lname'] +
                                              " \n" +
                                              students['studentID']),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ]),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                )),
    );
  }
}
