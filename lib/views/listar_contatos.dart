import 'package:app_contatos/model/contatos.dart';
import 'package:app_contatos/repository/backapp_repository.dart';
import 'package:app_contatos/views/criar_contato.dart';
import 'package:app_contatos/views/editar_contato.dart';
import 'package:flutter/material.dart';

class ListarContatosView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ListarContatosView({Key? key});

  @override
  State<ListarContatosView> createState() => _ListarContatosViewState();
}

class _ListarContatosViewState extends State<ListarContatosView> {
  Back4AppRepository back4AppRepository = Back4AppRepository();
  late Future<List<ContatosModel>> _contatosBack4AppModel;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _contatosBack4AppModel = getContatos();
  }

  Future<List<ContatosModel>> getContatos() async {
    List<ContatosModel> contatos = await back4AppRepository.getContatos();
    setState(() {
      loading = false;
    });
    return contatos;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> deleteContato(String objectId) async {
    try {
      await back4AppRepository.deleteContato(objectId);
      List<ContatosModel> updatedContatos = await getContatos();
      setState(() {
        _contatosBack4AppModel = Future.value(updatedContatos);
      });
      showSnackBar("Contato excluído com sucesso!");
    } catch (e) {
      showSnackBar("Erro ao excluir o contato: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : FutureBuilder<List<ContatosModel>>(
                future: _contatosBack4AppModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Nenhum contato encontrado.');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var contato = snapshot.data![index];
                        return Dismissible(
                          onDismissed: (DismissDirection dismissDirection) {
                            deleteContato(contato.objectId);
                          },
                          key: Key(contato.nome),
                          child: GestureDetector(
                            onTap: () async {
                              bool? result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditarContatoView(
                                    objectId: contato.objectId,
                                    nome: contato.nome,
                                    sobrenome: contato.sobrenome,
                                    status: contato.status,
                                    foto: contato.foto,
                                    telefone: contato.telefone,
                                  ),
                                ),
                              );

                              if (result == true) {
                                setState(() {
                                  _contatosBack4AppModel = getContatos();
                                });
                              }
                            },
                            child: ListTile(
                              leading: ClipOval(
                                child: Material(
                                  color: Colors.teal,
                                  child: InkWell(
                                    onTap: () {},
                                    child: SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: Image.network(
                                        contato.foto, // URL da imagem
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${contato.nome} ${contato.sobrenome}",
                              ),
                              subtitle: Text(contato.telefone),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CriarContatoView(
                objectId: 'default',
                nome: '',
                sobrenome: '',
                status: '',
                foto: '',
                telefone: '',
              ),
            ),
          );

          if (result == true) {
            setState(() {
              _contatosBack4AppModel = getContatos();
            });
          }
        },
        child: Icon(Icons.person_add_rounded),
      ),
    );
  }
}
