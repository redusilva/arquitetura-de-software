import 'package:flutter/material.dart';
import 'package:musa/views/academicLoginScreen.dart';
import 'package:musa/views/discipline/disciplineScreen.dart';
import 'package:musa/views/email/emailScreen.dart';
import 'package:musa/views/matr%C3%ADcula/matricula.dart';
import 'package:musa/views/nota/notaScreen.dart';
import 'package:musa/views/student/studentScreen.dart';
import 'package:musa/views/teacher/professorScreen.dart';

class AcademicHomeScreen extends StatefulWidget {
  const AcademicHomeScreen({Key? key}) : super(key: key);

  @override
  _AcademicHomeScreenState createState() => _AcademicHomeScreenState();
}

class _AcademicHomeScreenState extends State<AcademicHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  final List<_TabItem> _tabs = [
    _TabItem('Aluno', Icons.school, StudentRegistrationPage()),
    _TabItem('Professor', Icons.person_add_alt_rounded, ProfessorTab()),
    _TabItem('Disciplinas', Icons.book_rounded, DisciplineTab()),
    _TabItem('Cadastro', Icons.app_registration_rounded, MatriculaTab()),
    _TabItem('Boletim', Icons.assignment_rounded, GradeScreen()),
    _TabItem('Email', Icons.email_rounded, EmailTab()),

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
    final screenHeight = MediaQuery.of(context).size.height;
    final scale = screenHeight / 400;
    final double itemHeight = 42 * scale;
    final double itemSpacing = 6 * scale;

    List<Widget> list = [];
    for (int i = 0; i < _tabs.length; i++) {
      final tab = _tabs[i];
      final selected = _controller.index == i;
      list.add(Padding(
        padding: EdgeInsets.only(bottom: itemSpacing),
        child: InkWell(
          onTap: () => _controller.animateTo(i),
          borderRadius: BorderRadius.circular(10 * scale),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: itemHeight,
            padding: EdgeInsets.symmetric(horizontal: 6 * scale),
            decoration: BoxDecoration(
              color: selected ? Colors.white.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(10 * scale),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.5 * scale),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? Colors.amberAccent : Colors.white24,
                  ),
                  child: Icon(
                    tab.icon,
                    size: 16 * scale,
                    color: selected ? const Color(0xFF1E5288) : Colors.white70,
                  ),
                ),
                SizedBox(width: 6 * scale),
                Expanded(
                  child: Text(
                    tab.title,
                    style: TextStyle(
                      fontSize: 10 * scale,
                      fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                      color: selected ? Colors.amberAccent : Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    // Logout button
    list.add(Padding(
      padding: EdgeInsets.only(bottom: itemSpacing),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(10 * scale),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: itemHeight,
          padding: EdgeInsets.symmetric(horizontal: 6 * scale),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.5 * scale),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white24,
                ),
                child: Icon(
                  Icons.logout,
                  size: 16 * scale,
                  color: Colors.white70,
                ),
              ),
              SizedBox(width: 6 * scale),
              Expanded(
                child: Text(
                  'Sair',
                  style: TextStyle(
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));

    return Scaffold(
      body: CustomPaint(
        painter: AcademicBackgroundPainter(),
        child: SafeArea(
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 110 * scale,
                margin: EdgeInsets.symmetric(vertical: 12 * scale),
                padding: EdgeInsets.symmetric(vertical: 6 * scale),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E5288), Color(0xFF355C7D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(14 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8 * scale, bottom: 10 * scale),
                      child: Text(
                        'Seções',
                        style: TextStyle(
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 4 * scale),
                        child: SizedBox(
                          height: (_tabs.length + 1) * (itemHeight + itemSpacing),
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                top: _controller.index * (itemHeight + itemSpacing),
                                left: 0,
                                child: Container(
                                  width: 4 * scale,
                                  height: itemHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10 * scale),
                                      bottomRight: Radius.circular(10 * scale),
                                    ),
                                  ),
                                ),
                              ),
                              Column(children: list),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TabBarView(
                        controller: _controller,
                        children: _tabs.map((t) => t.page).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  final String title;
  final IconData icon;
  final Widget page;

  _TabItem(this.title, this.icon, this.page);
}