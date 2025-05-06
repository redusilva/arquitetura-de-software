import 'package:flutter/material.dart';

class StudentPage extends StatelessWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyleHeading = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    final textStyleSub = TextStyle(
      fontSize: 16,
      color: Colors.white70,
    );

    return Container(
      // match transparency of parent card
      color: Colors.transparent,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/student_avatar.jpg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Olá, Maria Silva', style: textStyleHeading),
                    SizedBox(height: 4),
                    Text('Nível: Avançado', style: textStyleSub),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),

            // Progress overview
            Text('Progresso Geral', style: textStyleHeading),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ProgressIndicator(
                    label: 'Cursos Concluídos',
                    percent: 0.75,
                    color: Colors.amberAccent,
                  ),
                  _ProgressIndicator(
                    label: 'Tarefas',
                    percent: 0.60,
                    color: Colors.cyanAccent,
                  ),
                  _ProgressIndicator(
                    label: 'Participações',
                    percent: 0.40,
                    color: Colors.limeAccent,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Upcoming assignments
            Text('Próximas Atividades', style: textStyleHeading),
            SizedBox(height: 12),
            Column(
              children: List.generate(
                3,
                (index) => Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.assignment, size: 36, color: Colors.amberAccent),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Trabalho de Matemática', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 4),
                            Text('Entregar em 2 dias', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                      Text('85%', style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),
            // Enrolled courses
            Text('Meus Cursos', style: textStyleHeading),
            SizedBox(height: 12),
            Container(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _CourseCard(title: 'Física', progress: 0.5),
                  _CourseCard(title: 'Química', progress: 0.3),
                  _CourseCard(title: 'Literatura', progress: 0.9),
                  _CourseCard(title: 'História', progress: 0.2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;

  const _ProgressIndicator({required this.label, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: percent,
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation(color),
                backgroundColor: Colors.white30,
              ),
            ),
            Text('${(percent * 100).round()}%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
        Container(width: 70, child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: Colors.white70))),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String title;
  final double progress;

  const _CourseCard({required this.title, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          Spacer(),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
          ),
          SizedBox(height: 4),
          Text('${(progress * 100).round()}%', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
