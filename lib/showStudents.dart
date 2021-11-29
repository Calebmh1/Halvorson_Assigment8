import 'package:flutter/material.dart';
import 'api.dart';
import 'editCourses.dart';
import 'editStudents.dart';
import 'main.dart';

class ShowStudents extends StatefulWidget {
  final CourseApi api = CourseApi();

  ShowStudents();

  @override
  _ShowStudentsState createState() => _ShowStudentsState();
}

class _ShowStudentsState extends State<ShowStudents> {
  _ShowStudentsState();

  List courses = [];
  List students = [];
  bool _dbloaded = false;

  void initState() {
    super.initState();

    widget.api.getAllCourses().then((data) {
      setState(() {
        courses = data;
        _dbloaded = true;
      });
    });

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
        title: Text(),
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
                                                        students['studentID'],
                                                        students[
                                                            'dateEntered']))),
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 30,
                                          child: Text(students['studentID']),
                                        ),
                                        title: Text(
                                          (students['fname'] +
                                              " " +
                                              students['lname']),
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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              }),
    );
  }
}
