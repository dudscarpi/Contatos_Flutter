// ignore_for_file: unnecessary_null_comparison

import 'package:app_contatos/model/contatos.dart';
import 'package:app_contatos/repository/back4app_custom_dio.dart';

const String defaultObjectId = 'default';
const String defaultNome = 'Desconhecido';
const String defaultSobrenome = '...';
const String defaultStatus = '...';
const String defaultFoto =
    'https://definicion.de/wp-content/uploads/2019/07/perfil-de-usuario.png';

class Back4AppRepository {
  final _customDio = Back4AppCustomDio();

  Back4AppRepository();

  List<ContatosModel> _parseContatosList(dynamic data) {
    if (data.containsKey('results')) {
      List<dynamic> contatosData = data['results'];
      return contatosData.map((json) => ContatosModel.fromJson(json)).toList();
    } else {
      throw Exception('Ocorreu um erro');
    }
  }

  Future<List<ContatosModel>> getContatos() async {
    try {
      var result = await _customDio.dio.get("/contatos");
      return _parseContatosList(result.data);
    } catch (e) {
      throw Exception('Ocorreu um erro ao buscar os contatos: $e');
    }
  }

  Future<ContatosModel> getContatoByTelefone(String telefone) async {
    List<ContatosModel> contatos = await getContatos();
    ContatosModel? contatoEncontrado = contatos.firstWhere(
      (contato) => contato.telefone == telefone,
      orElse: () => ContatosModel.create(
        defaultNome,
        defaultSobrenome,
        defaultStatus,
        defaultFoto,
        telefone,
      ),
    );

    return contatoEncontrado;
  }

  Future<void> createContato(ContatosModel contatosBack4AppModel) async {
    try {
      await _customDio.dio
          .post("/contatos", data: contatosBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw Exception('Ocorreu um erro ao criar o contato: $e');
    }
  }

  Future<void> updateContato(ContatosModel contatosBack4AppModel) async {
    try {
      await _customDio.dio.put("/contatos/${contatosBack4AppModel.objectId}",
          data: contatosBack4AppModel.toJsonEndpoint());
    } catch (e) {
      throw Exception('Ocorreu um erro ao atualizar o contato: $e');
    }
  }

  Future<void> deleteContato(String objectId) async {
    try {
      await _customDio.dio.delete("/contatos/$objectId");
    } catch (e) {
      throw Exception('Ocorreu um erro ao excluir o contato: $e');
    }
  }
}
