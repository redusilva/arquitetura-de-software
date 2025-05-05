import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> cadastrarProfessorNaDisciplina({
  required String teacherId,
  required String disciplineId,
  required String token,
}) async {
  final uri = Uri.parse('http://localhost:4003/disciplinas/teacher');

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
