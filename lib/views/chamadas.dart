import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_contatos/model/contatos.dart';
import 'package:app_contatos/repository/backapp_repository.dart';

class ChamadasView extends StatefulWidget {
  const ChamadasView({Key? key}) : super(key: key);

  @override
  State<ChamadasView> createState() => _ChamadasViewState();
}

class _ChamadasViewState extends State<ChamadasView> {
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
    contatos.sort((a, b) =>
        DateTime.parse(b.updatedAt).compareTo(DateTime.parse(a.updatedAt)));
    setState(() {
      loading = false;
    });
    return contatos;
  }

  Icon getIconByStatus(String status) {
    if (status == "Perdida") {
      return const Icon(Icons.phone_missed_rounded, color: Colors.redAccent);
    } else if (status == "Realizada") {
      return const Icon(Icons.phone_forwarded_rounded,
          color: Color.fromARGB(255, 84, 122, 105));
    } else if (status == "Recebida") {
      return const Icon(Icons.phone_callback, color: Colors.blueAccent);
    } else {
      return const Icon(
          Icons.phone); // Ícone padrão se o status não for reconhecido
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
                        DateTime dataCriacao =
                            DateTime.parse(contato.updatedAt);
                        String dataFormatada =
                            DateFormat('EEEE, HH:mm').format(dataCriacao);
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${contato.nome} ${contato.sobrenome}",
                              ),
                              getIconByStatus(
                                  contato.status), // Ícone à direita do texto
                            ],
                          ),
                          subtitle: Text(dataFormatada),
                        );
                      },
                    );
                  }
                },
              ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: ChamadasView()));
