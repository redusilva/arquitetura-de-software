import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> createProfessor({
  required String name,
  required String email,
  required String registration,
  required String token,
}) async {
  // Lê o host da API a partir do .env
  final apiHost = dotenv.env['server']!;
  final uri = Uri.http(apiHost, '/professores');

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token.toString(),
  };

  final body = jsonEncode({
    'name': name,
    'email': email,
    'registration': registration,
  });

  try {
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return ('Falha ao cadastrar aluno.' + response.statusCode.toString() + " " + response.body);
    }
  } catch (e) {
    return ('Erro ao conectar ao servidor: ' + e.toString());
  }
}
