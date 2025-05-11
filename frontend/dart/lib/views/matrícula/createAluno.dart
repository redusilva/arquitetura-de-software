
import 'package:flutter/material.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/matricula/createAluno.dart';
import 'package:musa/services/matricula/getAluno.dart';
import 'package:provider/provider.dart';

class AlunoDisciplineCreateTab extends StatefulWidget {
  const AlunoDisciplineCreateTab({Key? key}) : super(key: key);

  @override
  _AlunoDisciplineCreateTabState createState() => _AlunoDisciplineCreateTabState();
}

class _AlunoDisciplineCreateTabState extends State<AlunoDisciplineCreateTab> {
  final _formKey = GlobalKey<FormState>();
  final _disciplina = TextEditingController();
  final _Aluno = TextEditingController();
  final _regCtrl = TextEditingController();

  @override
  void dispose() {
    _disciplina.dispose();
    _Aluno.dispose();
    _regCtrl.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      final r = await cadastrarAlunoNaDisciplina(
        disciplineId: int.parse(_disciplina.text),
        studentId: int.parse(_Aluno.text),
        bearerToken:
            Provider.of<UserProvider>(context, listen: false).user!.token,
      );

      await getAllAlunosOfDisciplines(context);
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
                'Novo Aluno',
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
            controller: _disciplina,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.abc, color: Colors.white70),
              labelText: 'Id da discipina',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _Aluno,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person, color: Colors.white70),
              labelText: 'Id do Aluno',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (v) => v!.isEmpty ? 'Informe o email' : null,
          ),
      
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  _formKey.currentState?.reset();
                  _disciplina.clear();
                  _Aluno.clear();
                  _regCtrl.clear();
                },
                icon: const Icon(Icons.cancel, color: Colors.white70),
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
