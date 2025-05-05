import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> criarUsuario(String name, String email, String password) async {
  final url = Uri.parse('http://localhost:4000/users'); 

  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'name': name,
    'email': email,
    'password': password,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return('Usuário criado com sucesso: ${responseData['data']}');
    } else if (response.statusCode == 400) {
      final errorData = jsonDecode(response.body);
      return('Erro ao criar usuário: ${errorData['error']}');
    } else {
      return('Erro inesperado: ${response.statusCode}');
    }
  } catch (e) {
    return('Falha na requisição: $e');
  }
}