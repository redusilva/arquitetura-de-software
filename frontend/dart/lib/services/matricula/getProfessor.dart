import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:musa/models/teacherDiscipline.dart';
import 'package:musa/providers/teacherDisciplineProvider.dart';
import 'package:musa/providers/disciplineProvider.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:provider/provider.dart';

Future<dynamic> getAllProfessoresofDisciplines(BuildContext context) async {
  List<TeacherDicipline> lista = [];

  for (final i
      in Provider.of<SubjectProvider>(context, listen: false).subjects) {
    final professor = await getProfessoresDaDisciplina(
      i.id,
      Provider.of<UserProvider>(context, listen: false).user!.token,
    );
    if (professor == null) {
      print("foda-se esse valor");
    } else {
      lista.add(
        TeacherDicipline(
          id: professor['teacherId'] ?? "--",
          name: professor['teacherName'] ?? '--',
          disciplineName: i.id.toString(),
          email: professor['teacherEmail'] ?? '--',
          registration: professor['teacherRegistration'] ?? "---",
        ),
      );
    }
  }
  print("A lista final é:" + lista.toString());
  Provider.of<TeacherDisciplineProvider>(context,listen: false).teahers=lista;
  return null;
}

Future<dynamic> getProfessoresDaDisciplina(disciplinaId, String token) async {
  // lê o host do .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final url = Uri.http(apiHost, '/disciplinas/teacher/$disciplinaId');

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
      final List professores = jsonDecode(response.body);
      for (var professor in professores) {
        return professor;
      }
    } else {
      final error = jsonDecode(response.body);
      print('Erro ${response.statusCode}: ${error['error']}');
    }
  } catch (e) {
    print('Erro ao conectar: $e');
  }
}
