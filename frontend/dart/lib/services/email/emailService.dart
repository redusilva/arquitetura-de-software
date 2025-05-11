import 'dart:convert';
import 'package:http/http.dart' as http;

/// Envia um e-mail via POST /send-email.
///
/// [token] é o JWT usado para autorização.
/// [to] é o e-mail do destinatário.
/// [subject] é o assunto do e-mail.
/// [message] é o corpo da mensagem.
Future<dynamic> sendEmail({
  required String token,
  required String to,
  required String subject,
  required String message,
}) async {
  final uri = Uri.parse('http://localhost:4002/send-email');

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'to': to,
        'subject': subject,
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      print(response.body);
      return {
        'error': true,
        'statusCode': response.statusCode,
        'body': response.body,
      };
    }
  } catch (e) {
    print(e.toString());
    return {
      'error': true,
      'exception': e.toString(),
    };
  }
}
