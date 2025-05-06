import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> authenticateUser(int id, String token) async {
  // pega o host de auth do .env
  final authHost = dotenv.env['authServer']!;
  // monta a URI dinamicamente (HTTP)
  final url = Uri.http(authHost, '/users/authenticate/$id');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // se precisar, coloque aqui 'authorization': 'Bearer $token'
      },
      body: jsonEncode({'token': token}),
    );

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body);
        print('Token válido: ${data['message']}');
        break;
      case 400:
        final error = jsonDecode(response.body);
        print('Dados inválidos: ${error['error']}');
        break;
      case 401:
        final error = jsonDecode(response.body);
        print('Usuário não autorizado: ${error['error']}');
        break;
      case 404:
        final error = jsonDecode(response.body);
        print('Usuário não encontrado: ${error['error']}');
        break;
      default:
        print('Erro inesperado: ${response.statusCode}');
        print('Resposta: ${response.body}');
    }
  } catch (e) {
    print('Erro ao conectar com o servidor: $e');
  }
}