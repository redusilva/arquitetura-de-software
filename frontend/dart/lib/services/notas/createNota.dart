import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createNota({
  required int studentId,
  required int disciplineId,
  required double value,
  required String token,
}) async {
  // lê o host do .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final uri = Uri.http(apiHost, '/notas');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = jsonEncode({
    'studentId': studentId,
    'disciplineId': disciplineId,
    'value': value,
  });

  final response = await http.post(uri, headers: headers, body: body);

  final decoded = jsonDecode(response.body) as Map<String, dynamic>;
  if (response.statusCode == 201) {
    return decoded;
  } else {
    final errorMsg = decoded['error'] ?? decoded['message'] ?? 'Unknown error';
    throw Exception('Falha ao criar nota (${response.statusCode}): $errorMsg');
  }
}
