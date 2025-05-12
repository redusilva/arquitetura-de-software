import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:musa/models/userModel.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/auth/authService.dart';
import 'package:musa/views/academicHomeScreen.dart';
import 'package:provider/provider.dart';

Future<dynamic> realizarLogin(
  String email,
  String password,
  BuildContext context,
) async {
  // pega o host do servidor de auth do .env
  final authHost = dotenv.env['authServer']!;
  // monta a URI dinamicamente
  final url = Uri.http(authHost, '/users/login');

  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'email': email, 'password': password});

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body)['data'];

      Provider.of<UserProvider>(context, listen: false).user = UserModel(
        email: responseData['email'],
        id:    responseData['id'],
        name:  responseData['name'],
        token: responseData['token'],
      );

      await authenticateUser(
        Provider.of<UserProvider>(context, listen: false).user!.id,
        Provider.of<UserProvider>(context, listen: false).user!.token,
      );

      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => AcademicHomeScreen(),
          transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        ),
      );

      return true;
    } else if ([400, 401, 404].contains(response.statusCode)) {
      final errorData = jsonDecode(response.body);
      return 'Erro ao realizar login: ${errorData['error']}';
    } else {
      return 'Erro inesperado: ${response.statusCode}';
    }
  } catch (e) {
    return 'Falha na requisição: $e';
  }
}
