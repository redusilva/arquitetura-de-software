import 'package:flutter/material.dart';
import 'package:musa/models/discipline.dart';

class SubjectProvider with ChangeNotifier {
  List<Subject> _subjects = [];

  // Getter para a lista
  List<Subject> get subjects => _subjects;

  // Setter para substituir toda a lista
  set subjects(List<Subject> value) {
    _subjects = value;
    notifyListeners();
  }

  // Adiciona uma disciplina à lista
  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  // Remove uma disciplina por ID
  void removeSubjectById(int id) {
    _subjects.removeWhere((subject) => subject.id == id);
    notifyListeners();
  }

  // Limpa todas as disciplinas
  void clearSubjects() {
    _subjects.clear();
    notifyListeners();
  }
}
