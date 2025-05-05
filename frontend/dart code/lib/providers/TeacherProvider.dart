import 'package:flutter/material.dart';
import 'package:musa/models/teacher.dart';

class TeaacherProvider with ChangeNotifier {
  List<Teacher> _teahers = [];

  // Getter para a lista
  List<Teacher> get teahers => _teahers;

  // Setter para substituir toda a lista
  set teahers(List<Teacher> value) {
    _teahers = value;
    notifyListeners();
  }

  // Métodos adicionais opcionais
  void addStudent(Teacher student) {
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