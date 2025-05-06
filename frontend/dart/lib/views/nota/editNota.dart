
import 'package:flutter/material.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/notas/updateNota.dart';
import 'package:provider/provider.dart';

class GradeEditTab extends StatefulWidget {

  const GradeEditTab({Key? key, }) : super(key: key);

  @override
  _GradeEditTabState createState() => _GradeEditTabState();
}

class _GradeEditTabState extends State<GradeEditTab> {
  final _formKey = GlobalKey<FormState>();
  final _disciplina = TextEditingController();
  final _aluno = TextEditingController();
  final _nota = TextEditingController();

  @override
  void dispose() {
    _disciplina.dispose();
    _aluno.dispose();
    _nota.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
    

      final body = await updateNota(token: Provider.of<UserProvider>(context, listen: false).user!.token,id:  int.parse(_disciplina.text) ,value: double.parse(_nota.text) , );
      print("Todas as notaas do aluni: "+body.toString());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(body.toString())));

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
                'Editar nota',
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
              labelText: 'id da nota',
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
    
          const SizedBox(height: 8),
          TextFormField(
            controller: _nota,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.numbers, color: Colors.white70),
              labelText: 'Nota',
              labelStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (v) => v!.isEmpty ? 'Informe a matrícula' : null,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  _formKey.currentState?.reset();
                  _disciplina.clear();
                  _aluno.clear();
                  _nota.clear();
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
