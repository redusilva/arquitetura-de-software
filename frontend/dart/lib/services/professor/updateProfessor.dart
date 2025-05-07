import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> updateProfessor({
  required String id,
  required String name,
  required String email,
  required String registration,
  required String token,
}) async {
  final apiHost = dotenv.env['server']!;
  final uri = Uri.http(apiHost, '/professores/$id');

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = jsonEncode({
    'name': name,
    'email': email,
    'registration': registration,
  });

  try {
    final response = await http.put(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400) {
      return 'Requisição inválida (400): ${response.body}';
    } else if (response.statusCode == 404) {
      return 'Aluno não encontrado (404): ${response.body}';
    } else {
      return 'Falha ao atualizar aluno (${response.statusCode}): ${response.body}';
    }
  } catch (e) {
    return 'Erro ao conectar ao servidor: $e';
  }
}
