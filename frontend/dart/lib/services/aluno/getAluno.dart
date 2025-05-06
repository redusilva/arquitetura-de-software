import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musa/models/student.dart';
import 'package:musa/providers/studentProvider.dart';
import 'package:provider/provider.dart';

Future<String> getAlunos({
  required String token, 
  required BuildContext context
}) async {
  // lê o host do .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final uri = Uri.http(apiHost, '/alunos');

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token,
  };

  try {
    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      // Sucesso: retorna o corpo da resposta
      List<Student> l = [];

      final r = parseUsersFromJsonString(response.body);
      for (final i in r) {
        l.add(Student(
          id: i.id,
          name: i.name,
          email: i.email,
          registration: i.registration,
        ));
      }
      print("A lista é" + l.toString());
      Provider.of<StudentProvider>(context, listen: false).students = l;
      return response.body;
    } else {
      // Erro: lança uma exceção com o código e a mensagem
      throw Exception(
        'Falha ao obter alunos. Código: ${response.statusCode}. Mensagem: ${response.body}'
      );
    }
  } catch (e) {
    // Erro de conexão ou outros
    throw Exception('Erro ao conectar ao servidor: ' + e.toString());
  }
}

// Modelo de usuário
class ParsingStudent {
  final int id;
  final String name;
  final String email;
  final String registration;

  ParsingStudent({
    required this.id,
    required this.name,
    required this.email,
    required this.registration
  });

  factory ParsingStudent.fromJson(Map<String, dynamic> json) {
    return ParsingStudent(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      registration: json['registration']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'User{id: \$id, name: \$name, email: \$email, registration: \$registration}';
  }
}

// Função que converte JSON em string para List<User>
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
