import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musa/models/userModel.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/auth/authService.dart';
import 'package:musa/views/acad%C3%AAmicHomeScreen.dart';
import 'package:provider/provider.dart';

Future<dynamic> realizarLogin(
  String email,
  String password,
  BuildContext context,
) async {
  final url = Uri.parse('http://localhost:4000/users/login');

  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'email': email, 'password': password});

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body)['data'];



      Provider.of<UserProvider>(context,listen: false).user=UserModel(email:responseData['email'],id:  responseData['id'],name: responseData['name'],token: responseData['token']);

      await authenticateUser(Provider.of<UserProvider>(context,listen: false).user!.id, Provider.of<UserProvider>(context,listen: false).user!.token);

      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => AcademicHomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );

      return true;
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404) {
      final errorData = jsonDecode(response.body);
      return 'Erro ao realizar login: ${errorData['error']}';
    } else {
      return 'Erro inesperado: ${response.statusCode}';
    }
  } catch (e) {
    return 'Falha na requisição: $e';
  }
}
