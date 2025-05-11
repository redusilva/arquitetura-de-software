import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> updateAluno({
  required String id,
  required String name,
  required String email,
  required String registration,
  required String token,
}) async {
  // lê o host do .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final uri = Uri.http(apiHost, '/alunos/$id');

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
      // Sucesso: retorna o corpo da resposta
      return response.body;
    } else if (response.statusCode == 400) {
      return 'Requisição inválida (400): ${response.body}';
    } else if (response.statusCode == 404) {
      return 'Aluno não encontrado (404): ${response.body}';
    } else {
      return 'Falha ao atualizar aluno (${response.statusCode}): ${response.body}';
    }
  } catch (e) {
    // Erro de conexão ou outros
    return 'Erro ao conectar ao servidor: $e';
  }
}
