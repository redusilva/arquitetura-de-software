import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> updateDisciplina({
  required String id,
  required String name,
  required String token,
}) async {
  final uri = Uri.parse('http://localhost:4003/disciplinas/$id');

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = jsonEncode({
    'name': name,
  });

  try {
    final response = await http.put(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400) {
      return 'Requisição inválida (400): ${response.body}';
    } else if (response.statusCode == 404) {
      return 'Disciplina não encontrada (404): ${response.body}';
    } else {
      return 'Falha ao atualizar disciplina (${response.statusCode}): ${response.body}';
    }
  } catch (e) {
    return 'Erro ao conectar ao servidor: $e';
  }
}
