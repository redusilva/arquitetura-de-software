import 'package:flutter/material.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/email/emailService.dart';
import 'package:provider/provider.dart';

class EmailSendTab extends StatefulWidget {
  final Map<String, dynamic>? student;

  const EmailSendTab({Key? key, required this.student}) : super(key: key);

  @override
  _EmailSendTabState createState() => _EmailSendTabState();
}

class _EmailSendTabState extends State<EmailSendTab> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titulo;
  late TextEditingController _conteudo;
  late TextEditingController _destinatario;
  late TextEditingController _regCtrl;

  @override
  void initState() {
    super.initState();
    _titulo = TextEditingController(
      text: widget.student?['id']?.toString() ?? '',
    );
    _conteudo = TextEditingController(text: widget.student?['name'] ?? '');
    _destinatario = TextEditingController(text: widget.student?['email'] ?? '');
    _regCtrl = TextEditingController(
      text: widget.student?['registration'] ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant EmailSendTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.student != oldWidget.student) {
      _titulo.text = widget.student?['id']?.toString() ?? '';
      _conteudo.text = widget.student?['name'] ?? '';
      _destinatario.text = widget.student?['email'] ?? '';
      _regCtrl.text = widget.student?['registration'] ?? '';
    }
  }

  @override
  void dispose() {
    _titulo.dispose();
    _conteudo.dispose();
    _destinatario.dispose();
    _regCtrl.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      await sendEmail(
        token: Provider.of<UserProvider>(context, listen: false).user!.token,
        to: _destinatario.text,
        subject: _titulo.text,
        message: _conteudo.text,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email enviado!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.edit, color: Colors.amberAccent),
              SizedBox(width: 8),
              Text(
                'Enviar Email',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _titulo,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.title_rounded,
                color: Colors.white70,
              ),
              labelText: 'Titulo',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o título' : null,
          ),
          const SizedBox(height: 8),

          TextFormField(
            controller: _destinatario,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email, color: Colors.white70),
              labelText: 'Email',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o email' : null,
          ),
          const SizedBox(height: 8),

          TextFormField(
            controller: _conteudo,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.abc_rounded, color: Colors.white70),
              labelText: 'Conteúdo',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o conteúdo' : null,
          ),
          const SizedBox(height: 8),

          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _formKey.currentState?.reset(),
                icon: const Icon(Icons.clear_rounded, color: Colors.white70),
                label: const Text(
                  'Limpar',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _handleSave,
                icon: const Icon(Icons.send_rounded, color: Colors.black),
                label: const Text(
                  'Enviar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
