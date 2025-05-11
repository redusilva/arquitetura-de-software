import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:musa/providers/studentProvider.dart';
import 'package:provider/provider.dart';

Future<dynamic> fetchNotas({
  required int id,
  required String token,
  required BuildContext context,
}) async {
  // lê o host do .env
  final apiHost = dotenv.env['server']!;
  // monta a URI dinamicamente usando o host do .env
  final uri = Uri.http(apiHost, '/notas/$id');

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  if (Provider.of<StudentProvider>(context, listen: false)
          .students
          .any((student) => student.id == id) ==
      false) {
    return null;
  }

  final response = await http.get(uri, headers: headers);
  final decoded = jsonDecode(response.body);

  if (response.statusCode == 200) {
    // Esperamos um array de objetos
    return (decoded as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();
  } else {
    // Tenta extrair mensagem de erro
    if (decoded is Map<String, dynamic> && decoded.containsKey('error')) {
      return null;
    } else {
      return null;
    }
  }
}
