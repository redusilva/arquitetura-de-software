import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> deleteProfessor({
  required String id,
  required String token,
}) async {
  // Lê o host do .env
  final apiHost = dotenv.env['server']!;
  final uri = Uri.http(apiHost, '/professores/$id');

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.delete(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'] ?? 'Aluno deletado com sucesso!';
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
