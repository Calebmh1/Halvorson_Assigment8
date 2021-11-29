import 'dart:ffi';

import 'package:assignment8/api.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';

class EditCourses extends StatefulWidget {
  final String id;
  final String courseInstructor;
  final String courseCredits;
  final String courseID;
  final String courseName;
  final String dateEntered;

  final CourseApi api = CourseApi();

  EditCourses(this.id, this.courseInstructor, this.courseCredits, this.courseID,
      this.courseName, this.dateEntered);

  @override
  _EditCoursesState createState() => _EditCoursesState(
      id, courseInstructor, courseCredits, courseID, courseName, dateEntered);
}

class _EditCoursesState extends State<EditCourses> {
  final String id;
  final String courseInstructor;
  final String courseCredits;
  final String courseID;
  final String courseName;
  final String dateEntered;

  _EditCoursesState(this.id, this.courseInstructor, this.courseCredits,
      this.courseID, this.courseName, this.dateEntered);

  void _editStudent(id, fname) {
    setState(() {
      widget.api.editStudentByID(id, fname);
    });
  }

  List courses = [];
  List students = [];
  bool _dbloaded = false;
  void initState() {
    super.initState();

    widget.api.getAllStudents().then((data) {
      setState(() {
        students = data;
        _dbloaded = true;
      });
    });

    widget.api.getAllCourses().then((data) {
      setState(() {
        courses = data;
        _dbloaded = true;
      });
    });
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[],
              ))
        ]),
      ),
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
