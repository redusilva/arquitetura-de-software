import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:musa/models/studentDiscipline.dart';
import 'package:musa/providers/studentDisciplineProvider.dart';
import 'package:musa/providers/disciplineProvider.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:provider/provider.dart';

/// Para cada disciplina no SubjectProvider, busca o primeiro aluno
/// retornado pela API e adiciona à lista de StudentDiscipline.
Future<void> getAllAlunosOfDisciplines(BuildContext context) async {
  List<StudentDicipline> lista = [];

  final token = Provider.of<UserProvider>(context, listen: false).user!.token;
  final subjects = Provider.of<SubjectProvider>(context, listen: false).subjects;

  for (final disciplina in subjects) {
    final aluno = await getAlunosDaDisciplina(
      disciplina.id,
      token,
    );
    if (aluno == null) {
      print("Sem aluno para disciplina ${disciplina.id}");
    } else {
      lista.add(
        StudentDicipline(
          id: int.parse((aluno['id']?.toString() ?? "--")),
          disciplineName: aluno['disciplineId']?.toString() ?? "--",
          name: aluno['studentName'] ?? '--',
          email: aluno['studentEmail'] ?? '--',
          registration: aluno['studentRegistration'] ?? '--',
        ),
      );
    }
  }

  print("Lista final de alunos: $lista");
  Provider.of<StudentDisciplineProvider>(context, listen: false).teahers = lista;
}

/// Chama a API para buscar os alunos de uma disciplina e retorna o primeiro registro.
Future<Map<String, dynamic>?> getAlunosDaDisciplina(int disciplinaId, String token) async {
  // lê o host do .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final url = Uri.http(apiHost, '/disciplinas/aluno/$disciplinaId');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List alunos = jsonDecode(response.body);
      if (alunos.isNotEmpty) {
        return alunos.first as Map<String, dynamic>;
      }
    } else {
      final error = jsonDecode(response.body);
      print('Erro ${response.statusCode}: ${error['error']}');
    }
  } catch (e) {
    print('Erro ao conectar: $e');
  }

  return null;
}
