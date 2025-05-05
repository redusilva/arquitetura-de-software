import 'package:flutter/material.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/aluno/getAluno.dart';
import 'package:musa/services/aluno/uppdateAluno.dart';
import 'package:provider/provider.dart';

class StudentEditTab extends StatefulWidget {
  final Map<String, dynamic>? student;

  const StudentEditTab({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  _StudentEditTabState createState() => _StudentEditTabState();
}

class _StudentEditTabState extends State<StudentEditTab> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idCtrl;
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _regCtrl;

  @override
  void initState() {
    super.initState();
    _idCtrl = TextEditingController(text: widget.student?['id']?.toString() ?? '');
    _nameCtrl = TextEditingController(text: widget.student?['name'] ?? '');
    _emailCtrl = TextEditingController(text: widget.student?['email'] ?? '');
    _regCtrl = TextEditingController(text: widget.student?['registration'] ?? '');
  }

  @override
  void didUpdateWidget(covariant StudentEditTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.student != oldWidget.student) {
      _idCtrl.text = widget.student?['id']?.toString() ?? '';
      _nameCtrl.text = widget.student?['name'] ?? '';
      _emailCtrl.text = widget.student?['email'] ?? '';
      _regCtrl.text = widget.student?['registration'] ?? '';
    }
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _regCtrl.dispose();
    super.dispose();
  }

  void _handleSave() async{
    if (_formKey.currentState!.validate()) {
      await updateAluno(id:  _idCtrl.text, name: _nameCtrl.text, email: _emailCtrl.text, registration: _regCtrl.text, token: Provider.of<UserProvider>(context,listen:false).user!.token);
      await getAlunos(token: Provider.of<UserProvider>(context,listen:false).user!.token, context: context);
      
  
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aluno editado com sucesso!')),
      );
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
                'Editar Aluno',
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
            controller: _idCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.badge, color: Colors.white70),
              labelText: 'ID',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o ID' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person, color: Colors.white70),
              labelText: 'Nome',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email, color: Colors.white70),
              labelText: 'Email',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o email' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _regCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.credit_card, color: Colors.white70),
              labelText: 'Matrícula',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            validator: (v) => v!.isEmpty ? 'Informe a matrícula' : null,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _formKey.currentState?.reset(),
                icon: const Icon(Icons.cancel, color: Colors.white70),
                label: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _handleSave,
                icon: const Icon(Icons.save, color: Colors.black),
                label: const Text(
                  'Salvar',
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
