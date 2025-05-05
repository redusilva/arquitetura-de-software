import 'package:flutter/material.dart';
import 'list.dart';      // <-- Seu StudentListTab
import 'create.dart';    // <-- Seu StudentCreateTab

class NotasScreen extends StatefulWidget {
  const NotasScreen({Key? key}) : super(key: key);

  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 2 abas: Listar e Criar
    _tabController = TabController(length: 2, vsync: this);
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
            Tab(icon: Icon(Icons.person_add), text: 'Criar'),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              // ABA 1: agora exibindo a tela de busca de notas
              StudentListTab(),

              // ABA 2: Criar aluno
              StudentCreateTab(),
            ],
          ),
        ),
      ],
    );
  }
}
