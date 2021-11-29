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

  void _editStudent(id, fname) {
    setState(() {
      widget.api.editStudentByID(id, fname);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fname + " " + widget.lname,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    "change first name",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _editStudent(widget.id, nameController.text),
                          },
                      child: Text("Change name")),
                ],
              ),
            )
          ],
        ),
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







 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fname),
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
*/