import 'package:flutter/material.dart';
import 'createAluno.dart';
import 'createProfessor.dart';
import 'listAlunoDiscipline.dart';
import 'listProfessor.dart';

class MatriculaTab extends StatefulWidget {
  const MatriculaTab({Key? key}) : super(key: key);

  @override
  _MatriculaTabState createState() => _MatriculaTabState();
}

class _MatriculaTabState extends State<MatriculaTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _students = [];
  int _nextId = 1;
  int? _editId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void startEdit(Map<String, dynamic> s) {
    _editId = s['id'];
    _tabController.animateTo(2);
  }

  void startDelete(Map<String, dynamic> s) {
    _editId = s['id'];
    _tabController.animateTo(3);
  }

  void _addStudent(String name, String email, String registration) {
    setState(() {
      _students.add({
        'id': _nextId++,
        'name': name,
        'email': email,
        'registration': registration,
      });
    });
  }

  void editStudent(String name, String email, String registration) {
    setState(() {
      final idx = _students.indexWhere((s) => s['id'] == _editId);
      if (idx != -1) {
        _students[idx] = {
          'id': _editId,
          'name': name,
          'email': email,
          'registration': registration,
        };
      }
    });
  }

  void deleteStudent() {
    setState(() {
      _students.removeWhere((s) => s['id'] == _editId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white60,
            indicator: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(180),
            ),
            tabs: const [
              Tab(icon: Icon(Icons.list_alt_rounded), text: 'Listar Professores'),
              Tab(
                icon: Icon(Icons.person_add),
                text: 'Cadastrar professor em disciplina',
              ),
              Tab(icon: Icon(Icons.list_rounded), text: 'Listar Alunos'),
              Tab(icon: Icon(Icons.person_add), text: 'Cadastrar alunos'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.001),
                  Colors.black.withOpacity(0.001),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                ProfessorDisciplineListTab(),
                ProfessorDisciplineCreateTab(onCreate: _addStudent),
                StudentDisciplineListTab(),
                AlunoDisciplineCreateTab(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
