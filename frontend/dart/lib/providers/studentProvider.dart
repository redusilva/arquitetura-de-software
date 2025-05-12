import 'package:flutter/material.dart';
import 'package:musa/models/student.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];

  // Getter para a lista
  List<Student> get students => _students;

  // Setter para substituir toda a lista
  set students(List<Student> value) {
    _students = value;
    notifyListeners();
  }

  // Métodos adicionais opcionais
  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  void removeStudentById(int id) {
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
  }

  void clearStudents() {
    _students.clear();
    notifyListeners();
  }
}