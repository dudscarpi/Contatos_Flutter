import 'package:app_contatos/model/contatos.dart';
import 'package:app_contatos/repository/backapp_repository.dart';
import 'package:app_contatos/views/chamadas.dart';
import 'package:app_contatos/views/listar_contatos.dart';
import 'package:app_contatos/views/telefone.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectViewIndex = 1;

  _selectView(int index) {
    setState(() {
      _selectViewIndex = index;
    });
  }

  List<Map<String, Object>> _views = [];
  var back4AppHttpRepository = Back4AppRepository();
  var contatosModel = ContatosModel;

  @override
  void initState() {
    super.initState();
    _views = [
      {'title': 'Telefone', 'view': const TelefoneView()},
      {'title': 'Contatos', 'view': const ListarContatosView()},
      {'title': 'Chamadas', 'view': const ChamadasView()},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _views[_selectViewIndex]['title'] as String,
        ),
        centerTitle: true,
      ),
      body: _views[_selectViewIndex]['view'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectView,
          currentIndex: _selectViewIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Telefone',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded),
              label: 'Contatos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_in_talk),
              label: 'Chamadas',
            ),
          ]),
    );
  }
}
