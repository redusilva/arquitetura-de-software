import 'package:flutter/material.dart';
import 'package:musa/models/teacher.dart';
import 'package:musa/models/teacherDiscipline.dart';

class TeaacherDisciplineProvider with ChangeNotifier {
  List<TeacherDicipline> _teahers = [];

  // Getter para a lista
  List<TeacherDicipline> get teahers => _teahers;

  // Setter para substituir toda a lista
  set teahers(List<TeacherDicipline> value) {
    _teahers = value;
    notifyListeners();
  }

  // Métodos adicionais opcionais
  void addStudent(TeacherDicipline student) {
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