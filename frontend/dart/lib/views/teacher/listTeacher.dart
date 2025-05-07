import 'package:flutter/material.dart';
import 'package:musa/providers/teacherProvider.dart';
import 'package:provider/provider.dart';

class StudentListTab extends StatelessWidget {
  const StudentListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final students = Provider.of<TeacherProvider>(context).teahers;

    if (students.isEmpty) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.hourglass_empty, color: Colors.white60, size: 70),
            SizedBox(width: 8),
            Text(
              'Nenhum professor cadastrado',
              style: TextStyle(color: Colors.white70, fontSize: 30),
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
              student.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 "Email:" +student.email,
                  style: const TextStyle(color: Colors.white70),
                ),
                  Text(
                 "Matricula:" +student.registration,
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
                  student.id.toString(),
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
