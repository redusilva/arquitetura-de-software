import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> createAluno({
  required String name,
  required String email,
  required String registration,
  required String token,
}) async {
  // pega o host do servidor de .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final uri = Uri.http(apiHost, '/alunos');

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token,
  };

  final body = jsonEncode({
    'name': name,
    'email': email,
    'registration': registration,
  });

  try {
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      // Sucesso: retorna o corpo da resposta
      return response.body;
    } else {
      // Erro: retorna mensagem com código e corpo
      return 'Falha ao cadastrar aluno. '
          '${response.statusCode} '
          '${response.body}';
    }
  } catch (e) {
    // Erro de conexão ou outros
    return 'Erro ao conectar ao servidor: $e';
  }
}
