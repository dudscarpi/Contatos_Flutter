import 'package:flutter/material.dart';
import 'package:app_contatos/model/contatos.dart';
import 'package:app_contatos/repository/backapp_repository.dart';
import 'package:app_contatos/views/criar_contato.dart';
import 'package:app_contatos/views/ligacao.dart';

void main() => runApp(const MaterialApp(home: TelefoneView()));

class TelefoneView extends StatefulWidget {
  const TelefoneView({Key? key}) : super(key: key);

  @override
  _TelefoneViewState createState() => _TelefoneViewState();
}

const String defaultObjectId = 'default';
const String defaultNome = 'Desconhecido';
const String defaultSobrenome = '...';
const String defaultStatus = 'Recebida';
const String defaultFoto =
    'https://static.vecteezy.com/ti/vetor-gratis/p3/18765757-icone-de-perfil-de-usuario-em-estilo-simples-ilustracao-em-avatar-membro-no-fundo-isolado-conceito-de-negocio-de-sinal-de-permissao-humana-vetor.jpg';

class _TelefoneViewState extends State<TelefoneView> {
  String _numeroDigitado = '';

  void _removerNumero() {
    setState(() {
      if (_numeroDigitado.isNotEmpty) {
        _numeroDigitado =
            _numeroDigitado.substring(0, _numeroDigitado.length - 1);
      }
    });
  }

  void _adicionarNumero(String numero) {
    setState(() {
      _numeroDigitado += numero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: _numeroDigitado.isNotEmpty,
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CriarContatoView(
                            objectId: 'default',
                            nome: '',
                            sobrenome: '',
                            status: '',
                            foto: '',
                            telefone: _numeroDigitado,
                          ),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _numeroDigitado,
                        style: const TextStyle(fontSize: 32.0),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _removerNumero,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.backspace_outlined,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CriarContatoView(
                      objectId: 'default',
                      nome: '',
                      sobrenome: '',
                      status: '',
                      foto: '',
                      telefone: _numeroDigitado,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Criar Contato',
                  style: TextStyle(fontSize: 15.0, color: Colors.blueAccent),
                ),
              ),
            ),
            _buildNumericalPad(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericalPad() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNumberButton('1'),
            _buildNumberButton('2', subtitle: 'A B C'),
            _buildNumberButton('3', subtitle: 'D E F'),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNumberButton('4', subtitle: 'G H I'),
            _buildNumberButton('5', subtitle: 'J K L'),
            _buildNumberButton('6', subtitle: 'M N O'),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNumberButton('7', subtitle: 'P Q R S'),
            _buildNumberButton('8', subtitle: 'T U V'),
            _buildNumberButton('9', subtitle: 'W X Y Z'),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNumberButton('*'),
            _buildNumberButton('0', subtitle: '*'),
            _buildNumberButton('#'),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildNumberButtonCall(const Icon(Icons.call)),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButtonCall(Widget icon) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: IconButton(
        icon: icon,
        onPressed: () async {
          ContatosModel? existingContact =
              await Back4AppRepository().getContatoByTelefone(_numeroDigitado);

          // ignore: unnecessary_null_comparison
          if (existingContact != null) {
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LigacaoView(
                  objectId: existingContact.objectId,
                  nome: existingContact.nome,
                  sobrenome: existingContact.sobrenome,
                  status: existingContact.status,
                  foto: existingContact.foto,
                  telefone: _numeroDigitado,
                ),
              ),
            );
          } else {
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LigacaoView(
                  objectId: defaultObjectId,
                  nome: defaultNome,
                  sobrenome: defaultSobrenome,
                  status: defaultStatus,
                  foto: defaultFoto,
                  telefone: _numeroDigitado,
                ),
              ),
            );
          }
        },
        color: Colors.white,
      ),
    );
  }

  Widget _buildNumberButton(String number, {String? subtitle}) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ElevatedButton(
        onPressed: () {
          _adicionarNumero(number);
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 211, 211, 211),
          shape: const CircleBorder(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
