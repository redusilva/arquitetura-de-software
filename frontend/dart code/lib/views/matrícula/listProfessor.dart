import 'package:flutter/material.dart';
import 'package:musa/providers/TeacherDisciplineProvider.dart';
import 'package:musa/providers/TeacherProvider.dart';
import 'package:musa/providers/studentProvider.dart';
import 'package:provider/provider.dart';

class ProfessorListTab extends StatelessWidget {
  const ProfessorListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final students = Provider.of<TeaacherDisciplineProvider>(context).teahers;

    if (students.isEmpty) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.hourglass_empty, color: Colors.white60, size: 70),
            SizedBox(width: 8),
            Text(
              'Nenhum professor cadastrado',
              style: TextStyle(color: Colors.white70, fontSize: 50),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];

        return Card(
          color: Colors.white10,
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: const Icon(Icons.person, color: Colors.amberAccent),
              backgroundColor: Colors.white12,
            ),
            title: Text(
              student.registration,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 "Profesor:" +student.name,
                  style: const TextStyle(color: Colors.white70),
                ),
                  Text(
                 "Id disciplina" +student.discipline,
                  style: const TextStyle(color: Colors.white70),
                )
              ],
            ),
            isThreeLine: true,
            // Se você não for usar botões aqui, pode remover todo o `trailing`,
            // ou adicionar ações conforme necessário (editar, excluir, etc.).
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Exemplo de ação:
                Text(
                 "",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
