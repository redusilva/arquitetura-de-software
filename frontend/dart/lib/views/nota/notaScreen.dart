import 'package:flutter/material.dart';
import 'listNota.dart'; // <-- Seu StudentListTab
import 'createNota.dart'; // <-- Seu StudentCreateTab
import 'editNota.dart';
import 'deleteNota.dart';

class GradeScreen extends StatefulWidget {
  const GradeScreen({Key? key}) : super(key: key);

  @override
  _GradeScreenState createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar com só 2 abas
        TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white60,
          indicator: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(180),
          ),
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'Listar'),
            Tab(icon: Icon(Icons.person_add_rounded), text: 'Criar'),
            Tab(icon: Icon(Icons.edit_rounded), text: 'Editar'),
            Tab(icon: Icon(Icons.delete_rounded), text: 'Delete'),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              // ABA 1: agora exibindo a tela de busca de notas
              GradeListTab(),

              // ABA 2: Criar aluno
              GradeCreateTab(),
              GradeEditTab(),
              GradeDeleteTab(),
            ],
          ),
        ),
      ],
    );
  }
}
