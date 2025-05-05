import 'dart:convert';
import 'package:http/http.dart' as http;

/// Atualiza o valor de uma nota pelo ID.
/// Lança [Exception] em caso de erro na requisição.
Future<Map<String, dynamic>> updateNota({
  required int id,
  required double value,
  required String bearerToken,
}) async {
  final uri = Uri.parse('http://localhost:4003/nota/$id');
  final response = await http.put(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: jsonEncode({'value': value}),
  );

  switch (response.statusCode) {
    case 200:
      // Requisição executada com sucesso: retorna o JSON decodificado
      return jsonDecode(response.body) as Map<String, dynamic>;
    case 400:
      throw Exception('Requisição inválida: ${_extractError(response.body)}');
    case 404:
      throw Exception('Aluno ou disciplina não encontrados: ${_extractError(response.body)}');
    case 500:
      throw Exception('Erro interno do servidor: ${_extractError(response.body)}');
    default:
      throw Exception('Erro desconhecido [${response.statusCode}]: ${response.body}');
  }
}

/// Extrai a mensagem de erro do corpo JSON
String _extractError(String responseBody) {
  try {
    final map = jsonDecode(responseBody) as Map<String, dynamic>;
    return map['error'] ?? responseBody;
  } catch (_) {
    return responseBody;
  }
}