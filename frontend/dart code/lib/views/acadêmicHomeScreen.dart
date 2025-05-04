import 'package:flutter/material.dart';
import 'package:musa/views/acad%C3%AAmicLoginScreen.dart';
import 'package:musa/views/student/studentScreen.dart';
import 'package:musa/views/teacher/professorScreen.dart';

class AcademicHomeScreen extends StatefulWidget {
  const AcademicHomeScreen({Key? key}) : super(key: key);

  @override
  _AcademicHomeScreenState createState() => _AcademicHomeScreenState();
}

class _AcademicHomeScreenState extends State<AcademicHomeScreen>
    with SingleTickerProviderStateMixin {
  final double _itemHeight = 140;
  late TabController _controller;

  // Cada aba agora carrega seu próprio widget de página
  final List<_TabItem> _tabs = [
    _TabItem('Aluno', Icons.school, StudentRegistrationPage()),
    _TabItem('Professor', Icons.person_add_alt_rounded, ProfessorTab()),
    _TabItem('Disciplinas', Icons.book_rounded, LaboratoriosPage()),
    _TabItem('Matricula', Icons.rebase_edit, NotasPage()),
    _TabItem('Boletim', Icons.assignment_rounded, PerfilPage()),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _tabs.length, vsync: this)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: AcademicBackgroundPainter(),
        child: SafeArea(
          child: Row(
            children: [
              const SizedBox(width: 16),

              // Barra de abas vertical estilizada
              Container(
                width: 140,
                margin: const EdgeInsets.symmetric(vertical: 24),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E5288), Color(0xFF355C7D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, bottom: 16),
                      child: Text(
                        'Seções',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          // Indicador animado
                          AnimatedBuilder(
                            animation: _controller.animation!,
                            builder: (context, child) {
                              double indicatorY =
                                  _controller.animation!.value * _itemHeight;
                              return Positioned(
                                left: 0,
                                top: indicatorY + 16,
                                child: Container(
                                  width: 6,
                                  height: _itemHeight * 0.6,
                                  decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              );
                            },
                          ),
                          // Itens da aba
                          Column(
                            children: List.generate(_tabs.length, (index) {
                              final tab = _tabs[index];
                              final selected = _controller.index == index;
                              return InkWell(
                                onTap: () => _controller.animateTo(index),
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  height: _itemHeight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              selected
                                                  ? Colors.amberAccent
                                                  : Colors.white24,
                                        ),
                                        child: Icon(
                                          tab.icon,
                                          size: 48,
                                          color:
                                              selected
                                                  ? Color(0xFF1E5288)
                                                  : Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        tab.title,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight:
                                              selected
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                          color:
                                              selected
                                                  ? Colors.amberAccent
                                                  : Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                    // Botão de Logout na parte inferior
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: _itemHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white24,
                              ),
                              child: Icon(
                                Icons.logout,
                                size: 48,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Sair",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Conteúdo da aba
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TabBarView(
                        controller: _controller,
                        children: _tabs.map((t) => t.page).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Modelo de aba com widget de página
class _TabItem {
  final String title;
  final IconData icon;
  final Widget page;

  _TabItem(this.title, this.icon, this.page);
}

// cursos_page.dart

class CursosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Professor',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// laboratorios_page.dart

class LaboratoriosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Disciplina',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// notas_page.dart

class NotasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Matricula',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// perfil_page.dart

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Boletim',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
