import 'package:flutter/material.dart';
import 'package:musa/providers/studentProvider.dart';
import 'package:musa/providers/userLoginProvider.dart';
import 'package:musa/services/notas/get.dart';
import 'package:provider/provider.dart';

class StudentListTab extends StatefulWidget {
  const StudentListTab({Key? key}) : super(key: key);

  @override
  _StudentListTabState createState() => _StudentListTabState();
}

class _StudentListTabState extends State<StudentListTab> {
  List<dynamic> allStudents = [];
  final TextEditingController _idController = TextEditingController();
  int? _searchedId;

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  Future<void> _searchNotas() async {
    final text = _idController.text;
    final id = int.tryParse(text);
    if (id == null) return; // evita crash se não for número

    // guarda o ID pesquisado para exibir o ícone de limpar
    setState(() => _searchedId = id);

    // faz a requisição
    final body = await fetchNotas(
      context: context,
      token: Provider.of<UserProvider>(context, listen: false).user!.token,
      id: id,
    );

    if(body==null){
      return;
    }

    // atualiza a lista que será mostrada
    setState(() {
      allStudents = body;
    });
  }

  void _clearSearch() {
    _idController.clear();
    setState(() {
      _searchedId = null;
      allStudents = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Campo de pesquisa + botões
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Buscar por ID',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onSubmitted: (_) => _searchNotas(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: _searchNotas,
              ),
              if (_searchedId != null)
                IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white70),
                  onPressed: _clearSearch,
                ),
            ],
          ),
        ),

        // Resultado da busca
        Expanded(
          child: allStudents.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum registro encontrado',
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: allStudents.length,
                  itemBuilder: (context, index) {
                    final student = allStudents[index];
                    return Card(
                      color: Colors.white10,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: const Icon(Icons.person,
                              color: Colors.amberAccent),
                          backgroundColor: Colors.white12,
                        ),
                        title: Text(
                          'Aluno ID: ${student["studentId"]}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Disciplina: ${student['disciplineName']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'Nota: ${student['subjectNote']}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Text(
                          // mostra o ID da disciplina
                          student['disciplineId'].toString(),
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
