import 'package:flutter/material.dart';
import 'package:musa/providers/TeacherProvider.dart';
import 'package:musa/providers/disciplineProvider.dart';
import 'package:musa/providers/studentProvider.dart';
import 'package:provider/provider.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/views/acadêmicLoginScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(
          create: (_) => TeaacherProvider(),
        ), // <-- novo provider adicionado aqui
        // <-- novo provider adicionado aqui
        ChangeNotifierProvider(create: (_) => SubjectProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: AcademicLoginScreen(),
    );
  }
}
