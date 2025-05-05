import 'dart:convert';
import 'package:http/http.dart' as http;


Future<String> createProfessor({
  required String name,
  required String email,
  required String registration,
  required String token,
}) async {
  final uri = Uri.parse('http://localhost:4003/professores');

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer '+token.toString(),
  };

  final body = jsonEncode({
    'name': name,
    'email': email,
    'registration': registration,
  });

  try {
    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 201) {
      // Sucesso: retorna o corpo da resposta
      return response.body;
    } else {
      // Erro: lança uma exceção com o código e a mensagem
      return ('Falha ao cadastrar aluno.'+response.statusCode.toString()+" "+response.body);
    }
  } catch (e) {
    // Erro de conexão ou outros
    return ('Erro ao conectar ao servidor: '+e.toString());
  }
}
