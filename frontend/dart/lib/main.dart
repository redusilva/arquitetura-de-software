import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:musa/providers/studentDisciplineProvider.dart';
import 'package:musa/providers/teacherDisciplineProvider.dart';
import 'package:musa/providers/teacherProvider.dart';
import 'package:musa/providers/disciplineProvider.dart';
import 'package:musa/providers/studentProvider.dart';
import 'package:provider/provider.dart';
import 'package:musa/providers/userLoginProvider.dart';

// importe a sua SplashScreen
import 'package:musa/views/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => TeacherDisciplineProvider()),
        ChangeNotifierProvider(create: (_) => StudentDisciplineProvider()),
        ChangeNotifierProvider(create: (_) => TeacherProvider()),
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
      home: const SplashScreen(),
    );
  }
}
