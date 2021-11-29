import 'package:dio/dio.dart';

import './models/Students.dart';
import './models/Courses.dart';

const String localhost = "http://10.0.2.2:1200/";

class CourseApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getAllCourses() async {
    final response = await _dio.get('/getAllCourses');

    return response.data['courses'];
  }

  Future<List> getAllStudents() async {
    final response = await _dio.get('/getAllStudents');

    return response.data['students'];
  }

  Future<List> editStudentByID(String id, String fname) async {
    final response =
        await _dio.post('/editStudentByID', data: {'id': id, 'fname': fname});
    return response.data;
  }
}
