import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musa/models/discipline.dart';
import 'package:musa/providers/disciplineProvider.dart';
import 'package:provider/provider.dart';

Future<String> getDisciplinas({
  required String token,
  required BuildContext context,
}) async {
  final uri = Uri.parse('http://localhost:4003/disciplinas');

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<Subject> subjects = [];

      final parsed = parseSubjectsFromJsonString(response.body);
      for (final s in parsed) {
        subjects.add(Subject(id: s.id, name: s.name));
      }

      print("Disciplinas carregadas: $subjects");
      Provider.of<SubjectProvider>(context, listen: false).subjects = subjects;

      return response.body;
    } else {
      throw Exception(
          'Falha ao obter disciplinas. Código: ${response.statusCode}. Mensagem: ${response.body}');
    }
  } catch (e) {
    throw Exception('Erro ao conectar ao servidor: $e');
  }
}

// Classe para parsing
class ParsingSubject {
  final int id;
  final String name;

  ParsingSubject({
    required this.id,
    required this.name,
  });

  factory ParsingSubject.fromJson(Map<String, dynamic> json) {
    return ParsingSubject(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'Subject{id: $id, name: $name}';
  }
}

// Função para converter a lista JSON
List<ParsingSubject> parseSubjectsFromJsonString(String jsonString) {
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is List) {
    return decoded
        .map((item) => ParsingSubject.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw FormatException('JSON não representa uma lista de disciplinas');
  }
}
