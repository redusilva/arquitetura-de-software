import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> deleteDisciplina({
  required String id,
  required String token,
}) async {
  final uri = Uri.parse('http://localhost:4003/disciplinas/$id');

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      // Sucesso: retorna mensagem do servidor
      final data = jsonDecode(response.body);
      return data['message'] ?? 'Disciplina removida com sucesso!';
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      final data = jsonDecode(response.body);
      return 'Erro: ${data['error'] ?? 'Erro desconhecido'}';
    } else {
      return 'Erro inesperado: ${response.statusCode} ${response.body}';
    }
  } catch (e) {
    return 'Erro ao conectar ao servidor: $e';
  }
}
