import 'package:app_contatos/model/contatos.dart';
import 'package:app_contatos/repository/backapp_repository.dart';
import 'package:app_contatos/views/nav.dart';
import 'package:flutter/material.dart';

class LigacaoView extends StatefulWidget {
  final String objectId;
  final String nome;
  final String sobrenome;
  final String status;
  final String foto;
  final String telefone;

  const LigacaoView({
    Key? key,
    required this.objectId,
    required this.nome,
    required this.sobrenome,
    required this.status,
    required this.foto,
    required this.telefone,
  }) : super(key: key);

  @override
  _LigacaoViewState createState() => _LigacaoViewState();
}

class _LigacaoViewState extends State<LigacaoView> {
  ContatosModel? contatoEncontrado;

  @override
  void initState() {
    super.initState();
    _getContatoByTelefone();
  }

  Future<void> _getContatoByTelefone() async {
    var existingContact =
        await Back4AppRepository().getContatoByTelefone(widget.telefone);
    setState(() {
      contatoEncontrado = existingContact;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ligação'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: contatoEncontrado != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(contatoEncontrado
                                    ?.foto ??
                                'https://static.vecteezy.com/ti/vetor-gratis/p3/18765757-icone-de-perfil-de-usuario-em-estilo-simples-ilustracao-em-avatar-membro-no-fundo-isolado-conceito-de-negocio-de-sinal-de-permissao-humana-vetor.jpg'),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            contatoEncontrado?.nome ?? 'Desconhecido',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Ligando...',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          'Ligando...',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtons(const Icon(Icons.mic_off), 'Mute'),
              _buildButtons(const Icon(Icons.apps), 'Keypad'),
              _buildButtons(const Icon(Icons.volume_up), 'Speaker'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtons(const Icon(Icons.add), 'Add Call'),
              _buildButtons(const Icon(Icons.video_call_sharp), 'Video'),
              _buildButtons(const Icon(Icons.people_rounded), 'Contacts'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonOff(const Icon(Icons.call_end)),
            ],
          ),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _buildButtons(Widget icon, String label) {
    return SizedBox(
      width: 80.0,
      height: 120.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 126, 126, 126),
            ),
            child: IconButton(
              icon: icon,
              onPressed: () {},
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonOff(Widget icon) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: IconButton(
        icon: icon,
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.white,
      ),
    );
  }
}
