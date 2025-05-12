import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Deleta uma nota no sistema.
///
/// [token] é o token JWT para autenticação Bearer.
/// Retorna o JSON de resposta em caso de sucesso, ou lança uma exceção em caso de erro.
Future<Map<String, dynamic>> deleteNota({
  required int id,
  required String token,
}) async {
  // lê o host do .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final uri = Uri.http(apiHost, '/notas/$id');

  final response = await http.delete(
    uri,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  switch (response.statusCode) {
    case 200:
      // Parse e retorna o JSON de sucesso
      return jsonDecode(response.body) as Map<String, dynamic>;
    case 400:
      throw Exception('Requisição inválida: ${jsonDecode(response.body)['error']}');
    case 404:
      throw Exception('Recurso não encontrado: ${jsonDecode(response.body)['error']}');
    case 500:
      throw Exception('Erro interno do servidor: ${jsonDecode(response.body)['error']}');
    default:
      throw Exception('Erro inesperado (${response.statusCode}): ${response.body}');
  }
}
