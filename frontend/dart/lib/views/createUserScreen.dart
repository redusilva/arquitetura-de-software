import 'package:flutter/material.dart';
import 'package:musa/services/createUserService/createUserService.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({Key? key}) : super(key: key);

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final logoHeight = screenSize.height * 0.3; // 40% da altura da tela
    return Scaffold(
      body: CustomPaint(
        painter: AcademicBackgroundPainter(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/musa.png',
                  height: logoHeight,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: screenSize.height * 0.002,
                ), // margem de 3% da altura
              ],
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.school_rounded,
                          size: 64,
                          color: Color(0xFF1E5288),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Criar Usuário',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E5288),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          controller: _controllerNome,
                          hintText: 'Nome de Usuário',
                          prefixIcon: Icons.person_rounded,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _controllerEmail,
                          hintText: 'Email',
                          prefixIcon: Icons.email_rounded,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _controllerSenha,
                          hintText: 'Senha',
                          prefixIcon: Icons.lock_rounded,
                          obscureText: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Já possui conta?'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(280),
                              ),
                              backgroundColor: const Color(0xFF1E5288),
                            ),
                            onPressed: () async {
                              final resposta = await criarUsuario(
                                _controllerNome.text,
                                _controllerEmail.text,
                                _controllerSenha.text,
                              );
                              showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // impede fechar clicando fora
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: const Text(
                                      'Atenção',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      resposta.toString(),
                                      textAlign: TextAlign.justify,
                                    ),
                                    actions: <Widget>[
                                      //TextButton(
                                      //    child: const Text('Cancelar'),
                                      //    onPressed: () {
                                      //      Navigator.of(context).pop();
                                      //     },
                                      //    ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.deepPurple,
                                        ),
                                        child: const Text('ok'),
                                        onPressed: () {
                                          // Ação ao aceitar
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              'Registrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF1E5288)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(180),
          borderSide: const BorderSide(color: Color(0xFFB0C4DE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: Color(0xFF1E5288)),
        ),
      ),
    );
  }
}

class AcademicBackgroundPainter extends CustomPainter {
  final Color backgroundColor = const Color(0xFF4C7CB5);
  final Color iconColor = const Color(0xFF1E5288);
  final List<IconData> icons = const [
    Icons.school_rounded,
    Icons.menu_book_rounded,
    Icons.science_rounded,
    Icons.straighten_rounded,
    Icons.biotech_rounded,
    Icons.book_rounded,
    Icons.calculate_rounded,
    Icons.abc_rounded,
    Icons.public_rounded,
    Icons.edit_rounded,
    Icons.account_balance_rounded,
  ];
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    const double iconSize = 48;
    const double padding = 20;
    final rows = (size.height / (iconSize + padding)).ceil();
    final cols = (size.width / (iconSize + padding)).ceil();

    for (int i = 0; i <= rows; i++) {
      for (int j = 0; j <= cols; j++) {
        final dx = j * (iconSize + padding) + padding / 2;
        final dy = i * (iconSize + padding) + padding / 2;
        final index = (i * cols + j) % icons.length;
        _drawIcon(canvas, Offset(dx, dy), iconSize, icons[index]);
      }
    }
  }

  void _drawIcon(Canvas canvas, Offset offset, double size, IconData iconData) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          fontSize: size,
          fontFamily: iconData.fontFamily,
          package: iconData.fontPackage,
          color: iconColor.withOpacity(0.6), // aumentada de 0.3 para 0.6
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
