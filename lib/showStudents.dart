import 'package:flutter/material.dart';
import 'api.dart';
import 'editCourses.dart';
import 'editStudents.dart';
import 'main.dart';

class ShowStudents extends StatefulWidget {
  final CourseApi api = CourseApi();

  final String id;
  final String courseName;
  ShowStudents(this.id, this.courseName);

  @override
  _ShowStudentsState createState() => _ShowStudentsState(id, courseName);
}

class _ShowStudentsState extends State<ShowStudents> {
  _ShowStudentsState(id, courseName);

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

  void _deleteCourse(id) {
    setState(() {
      widget.api.deleteCourseByID(id);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: <Widget>[
          PopupMenuItem(
            onTap: () {
              _deleteCourse(widget.id);
            },
            child: Text(
              "DELETE COURSE?",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
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
