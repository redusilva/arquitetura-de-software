import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:musa/providers/teacherProvider.dart';
import 'package:musa/models/teacher.dart';
import 'package:provider/provider.dart';

Future<String> getProfesspr({
  required String token,
  required BuildContext context,
}) async {
  final apiHost = dotenv.env['server']!;
  final uri = Uri.http(apiHost, '/professores');

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<Teacher> l = [];
      final r = parseUsersFromJsonString(response.body);
      for (final i in r) {
        l.add(Teacher(id: i.id, name: i.name, email: i.email, registration: i.registration));
      }
      print("A lista é" + l.toString());
      Provider.of<TeacherProvider>(context, listen: false).teahers = l;
      return response.body;
    } else {
      throw Exception(
          'Falha ao obter alunos. Código: ${response.statusCode}. Mensagem: ${response.body}');
    }
  } catch (e) {
    throw Exception('Erro ao conectar ao servidor: ' + e.toString());
  }
}

class ParsingStudent {
  final int id;
  final String name;
  final String email;
  final String registration;

  ParsingStudent({
    required this.id,
    required this.name,
    required this.email,
    required this.registration,
  });

  factory ParsingStudent.fromJson(Map<String, dynamic> json) {
    return ParsingStudent(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      registration: json['registration']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, registration: $registration}';
  }
}

List<ParsingStudent> parseUsersFromJsonString(String jsonString) {
  final dynamic decoded = jsonDecode(jsonString);
  if (decoded is List) {
    return decoded
        .map((item) => ParsingStudent.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw FormatException('JSON não representa uma lista de usuários');
  }
}
