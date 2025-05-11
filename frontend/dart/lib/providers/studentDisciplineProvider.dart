import 'package:flutter/material.dart';
import 'package:musa/models/studentDiscipline.dart';

class StudentDisciplineProvider with ChangeNotifier {
  List<StudentDicipline> _teahers = [];

  // Getter para a lista
  List<StudentDicipline> get teahers => _teahers;

  // Setter para substituir toda a lista
  set teahers(List<StudentDicipline> value) {
    _teahers = value;
    notifyListeners();
  }

  // Métodos adicionais opcionais
  void addStudent(StudentDicipline student) {
    _teahers.add(student);
    notifyListeners();
  }

  void removeStudentById(int id) {
    _teahers.removeWhere((student) => student.id == id);
    notifyListeners();
  }

  void clearStudents() {
    _teahers.clear();
    notifyListeners();
  }
}