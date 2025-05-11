
import 'package:flutter/material.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/matricula/createProfessor.dart';
import 'package:musa/services/matricula/getProfessor.dart';
import 'package:provider/provider.dart';

class ProfessorDisciplineCreateTab extends StatefulWidget {
  final void Function(String name, String email, String registration) onCreate;

  const ProfessorDisciplineCreateTab({Key? key, required this.onCreate})
    : super(key: key);

  @override
  _ProfessorDisciplineCreateTabState createState() => _ProfessorDisciplineCreateTabState();
}

class _ProfessorDisciplineCreateTabState extends State<ProfessorDisciplineCreateTab> {
  final _formKey = GlobalKey<FormState>();
  final _Professor = TextEditingController();
  final _disciplina = TextEditingController();
  final _regCtrl = TextEditingController();

  @override
  void dispose() {
    _Professor.dispose();
    _disciplina.dispose();
    _regCtrl.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      final r = await cadastrarProfessorNaDisciplina(
        disciplineId: _disciplina.text,
        teacherId: _Professor.text,
        token: Provider.of<UserProvider>(context, listen: false).user!.token,
      );

      await getAllProfessoresofDisciplines(context);

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
                'Novo professor',
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
            controller: _Professor,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person, color: Colors.white70),
              labelText: 'ID do professor',
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
            controller: _disciplina,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email, color: Colors.white70),
              labelText: 'Id da disciplina',
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

          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  _formKey.currentState?.reset();
                  _Professor.clear();
                  _disciplina.clear();
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
