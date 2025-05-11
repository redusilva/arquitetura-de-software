import 'dart:async';
import 'package:flutter/material.dart';
import 'package:musa/views/academicLoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _navigationTimer;
  late Timer _dotsTimer;
  int _dotCount = 0;

  @override
  void initState() {
    super.initState();
    // Timer para navegação após 5s
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => AcademicLoginScreen()),
      );
    });
    // Timer para animação de pontos
    _dotsTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // 0,1,2,3 pontos
      });
    });
  }

  @override
  void dispose() {
    _navigationTimer.cancel();
    _dotsTimer.cancel();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final logoHeight = screenSize.height * 0.5; // 40% da altura da tela

  return Scaffold(
    body: CustomPaint(
      painter: AcademicBackgroundPainter(),
      size: screenSize,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/musa.png',
              height: logoHeight,
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenSize.height * 0.1), // margem de 3% da altura
            Text(
              'Carregando${'.' * _dotCount}',
              style: TextStyle(
                fontSize: screenSize.height * 0.05, // 2% da altura
                color: Colors.white,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}