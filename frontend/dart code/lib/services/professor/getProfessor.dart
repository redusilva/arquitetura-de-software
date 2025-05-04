import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musa/models/TeacherProvider.dart';
import 'package:musa/models/student.dart';
import 'package:musa/models/teacher.dart';
import 'package:musa/providers/studentProvider.dart';
import 'package:provider/provider.dart';
Future<String> getProfesspr({
  required String token, required BuildContext context
}) async {
  final uri = Uri.parse('http://localhost:4003/professores');

  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token,
  };

  try {
    final response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      // Sucesso: retorna o corpo da resposta
        List<Teacher> l=[];

      final r=parseUsersFromJsonString(response.body);
      for(final i in r){

        l.add(Teacher(id: i.id, name: i.name, email: i.email, registration: i.registration));
      }
      print("A lista é"+l.toString());
    Provider.of<TeaacherProvider>(context,listen: false).teahers=l;
      return response.body;
    } else {
      // Erro: lança uma exceção com o código e a mensagem
      throw Exception(
          'Falha ao obter alunos. Código: ${response.statusCode}. Mensagem: ${response.body}');
    }
  } catch (e) {
    // Erro de conexão ou outros
    throw Exception('Erro ao conectar ao servidor: ' + e.toString());
  }
}



// Modelo de usuário
class ParsingStudent {
  final int id;
  final String name;
  final String email;
  final String registration;

  ParsingStudent({required this.id, required this.name, required this.email, required this.registration});

  // Factory para criar instância de User a partir de map
  factory ParsingStudent.fromJson(Map<String, dynamic> json) {
    return ParsingStudent(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      registration: json['registration']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'User{id: \$id, name: \$name, email: \$email, registration: \$registration}';
  }
}

// Função que converte JSON em string para List<User>
List<ParsingStudent> parseUsersFromJsonString(String jsonString) {
  // Decodifica a string JSON
  final dynamic decoded = jsonDecode(jsonString);
  
  // Verifica se o decoded é uma lista
  if (decoded is List) {
    return decoded
        .map((item) => ParsingStudent.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    throw FormatException('JSON não representa uma lista de usuários');
  }
}
