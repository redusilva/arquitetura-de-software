import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> createNota({
  required int studentId,
  required int disciplineId,
  required double value,
  required String token,
}) async {
  final uri = Uri.parse('http://localhost:4003/notas');
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







