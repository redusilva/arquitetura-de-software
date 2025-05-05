import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> createDisciplina({
  required String name,
  required String token,
}) async {
  final uri = Uri.parse('http://localhost:4003/disciplinas');

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token,
  };

  final body = jsonEncode({
    'name': name,
  });

  try {
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      return response.body; // Sucesso
    } else {
      return 'Falha ao cadastrar disciplina. '
             'Código: ${response.statusCode}, Corpo: ${response.body}';
    }
  } catch (e) {
    return 'Erro ao conectar ao servidor: $e';
  }
}
