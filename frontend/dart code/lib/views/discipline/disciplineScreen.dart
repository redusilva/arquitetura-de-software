import 'package:flutter/material.dart';
import 'create.dart';
import 'delete.dart';
import 'edit.dart';
import 'list.dart';


class DisciplineTab extends StatefulWidget {
  const DisciplineTab({Key? key}) : super(key: key);

  @override
  _DisciplineTabState createState() =>
      _DisciplineTabState();
}

class _DisciplineTabState extends State<DisciplineTab>
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

  void _startEdit(Map<String, dynamic> s) {
    _editId = s['id'];
    _tabController.animateTo(2);
  }

  void _startDelete(Map<String, dynamic> s) {
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

  void _editStudent(String name, String email, String registration) {
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

  void _deleteStudent() {
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
              Tab(icon: Icon(Icons.list), text: 'Listar'),
              Tab(icon: Icon(Icons.person_add), text: 'Criar'),
              Tab(icon: Icon(Icons.edit), text: 'Editar'),
              Tab(icon: Icon(Icons.delete_forever), text: 'Deletar'),
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
                StudentListTab(
           
                ),
                StudentCreateTab(onCreate: _addStudent),
                StudentEditTab(
                  student: _students.firstWhere(
                    (s) => s['id'] == _editId,
                    orElse: () => {},
                  ),
                  
                ),
                StudentDeleteTab(
                  student: _students.firstWhere(
                    (s) => s['id'] == _editId,
                    orElse: () => {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


