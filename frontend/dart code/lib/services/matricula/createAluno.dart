import 'dart:convert';
import 'package:http/http.dart' as http;

/// Lança [HttpException] em caso de erro.
Future<Map<String, dynamic>> cadastrarAlunoNaDisciplina({
  required int studentId,
  required int disciplineId,
  required String bearerToken,
}) async {
  final uri = Uri.parse('http://localhost:4003/disciplinas/aluno');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $bearerToken',
  };
  final body = jsonEncode({
    'studentId': studentId,
    'disciplineId': disciplineId,
  });

  final response = await http.post(uri, headers: headers, body: body);

  switch (response.statusCode) {
    case 200:
      // Sucesso: decodifica e retorna o JSON da resposta
      return jsonDecode(response.body) as Map<String, dynamic>;

    case 400:
      // Requisição inválida
      final error = jsonDecode(response.body)['error'] as String? 
          ?? 'Requisição inválida';
      throw HttpException('400 Bad Request: $error');

    case 404:
      // Aluno ou disciplina não encontrados
      final error = jsonDecode(response.body)['error'] as String? 
          ?? 'Recurso não encontrado';
      throw HttpException('404 Not Found: $error');

    default:
      // Qualquer outro erro (inclui 500)
      final errorMsg = response.body.isNotEmpty
          ? (jsonDecode(response.body)['error'] ?? response.body)
          : 'Status code ${response.statusCode}';
      throw HttpException('${response.statusCode}: $errorMsg');
  }
}

/// Exceção simples para erros HTTP
class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => 'HttpException: $message';
}