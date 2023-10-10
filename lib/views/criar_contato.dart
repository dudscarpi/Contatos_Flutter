import 'package:app_contatos/model/contatos.dart';
import 'package:app_contatos/repository/backapp_repository.dart';
import 'package:app_contatos/views/nav.dart';
import 'package:flutter/material.dart';

class CriarContatoView extends StatelessWidget {
  final String objectId;
  final String nome;
  final String sobrenome;
  final String status;
  final String foto;
  final String telefone;

  const CriarContatoView({
    super.key,
    required this.objectId,
    required this.nome,
    required this.sobrenome,
    required this.status,
    required this.foto,
    required this.telefone,
  });

  @override
  Widget build(BuildContext context) {
    var nomeController = TextEditingController();
    var sobrenomeController = TextEditingController();
    var statusController = TextEditingController();
    var fotoController = TextEditingController();
    var telefoneController = TextEditingController(text: telefone);

    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Nav()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Contato"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: sobrenomeController,
                  decoration: InputDecoration(
                    labelText: 'Sobrenome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: statusController,
                  decoration: InputDecoration(
                    labelText: 'Status Fictício',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: fotoController,
                  decoration: InputDecoration(
                    labelText: 'Url da Foto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: telefoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (nomeController.text.isEmpty ||
                        sobrenomeController.text.isEmpty ||
                        statusController.text.isEmpty ||
                        fotoController.text.isEmpty ||
                        telefoneController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Ops!! Algo deu errado!"),
                            content: const Wrap(
                              children: [
                                Text(
                                  "Preencha todos os campos antes de tentar enviar o contato!",
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      await Back4AppRepository().createContato(
                        ContatosModel.create(
                          nomeController.text,
                          sobrenomeController.text,
                          statusController.text,
                          fotoController.text,
                          telefoneController.text,
                        ),
                      );
                      showSnackBar("Contato criado com sucesso!");
                    }
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
