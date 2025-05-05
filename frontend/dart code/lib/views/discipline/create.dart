import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/aluno/createAluno.dart';
import 'package:musa/services/aluno/getAluno.dart';
import 'package:musa/services/disciplina/create.dart';
import 'package:musa/services/disciplina/get.dart';
import 'package:musa/services/professor/createProfessor.dart';
import 'package:musa/services/professor/getProfessor.dart';
import 'package:provider/provider.dart';

class StudentCreateTab extends StatefulWidget {
  final void Function(String name, String email, String registration) onCreate;

  const StudentCreateTab({Key? key, required this.onCreate}) : super(key: key);

  @override
  _StudentCreateTabState createState() => _StudentCreateTabState();
}

class _StudentCreateTabState extends State<StudentCreateTab> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _regCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _regCtrl.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      final r = await createDisciplina(
        name: _nameCtrl.text,
        token: Provider.of<UserProvider>(context, listen: false).user!.token,
      );

      final body =await getDisciplinas(token: Provider.of<UserProvider>(context, listen: false).user!.token,context:context);
      print("Corpo da resposta: "+body);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(r.toString())));

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
              Icon(Icons.person_add, color: Colors.amberAccent),
              SizedBox(width: 8),
              Text(
                'Nova disciplina',
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
            controller: _nameCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person, color: Colors.white70),
              labelText: 'Nome',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
          ),
 
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  _formKey.currentState?.reset();
                  _nameCtrl.clear();
                  _emailCtrl.clear();
                  _regCtrl.clear();
                },
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
                    borderRadius: BorderRadius.circular(8),
                  ),
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
