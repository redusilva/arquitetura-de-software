import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> cadastrarProfessorNaDisciplina({
  required String teacherId,
  required String disciplineId,
  required String token,
}) async {
  // lê o host do .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final uri = Uri.http(apiHost, '/disciplinas/teacher');

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = jsonEncode({
    'teacherId': int.parse(teacherId),
    'disciplineId': int.parse(disciplineId),
  });

  try {
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Sucesso: retorna a mensagem do servidor
      final decoded = jsonDecode(response.body);
      return decoded['message'] ?? 'Professor cadastrado com sucesso!';
    } else {
      // Erro: retorna o código e o corpo da resposta
      return 'Erro ${response.statusCode}: ${response.body}';
    }
  } catch (e) {
    // Erro de conexão ou outro
    return 'Erro ao conectar ao servidor: $e';
  }
}
