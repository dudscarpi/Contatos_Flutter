class Contatos {
  List<ContatosModel> contatos = [];

  Contatos(this.contatos);

  Contatos.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contatos = <ContatosModel>[];
      json['results'].forEach((v) {
        contatos.add(ContatosModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = contatos.map((v) => v.toJson()).toList();
    return data;
  }
}

class ContatosModel {
  String _objectId = "";
  String _nome = "";
  String _sobrenome = "";
  String _status = "";
  String _foto = "";
  String _telefone = "";
  String _createdAt = "";
  String _updatedAt = "";

  ContatosModel(this._nome, this._sobrenome, this._status, this._foto,
      this._telefone, this._createdAt, this._updatedAt,
      {required String objectId,
      required String nome,
      required String sobrenome,
      required String status,
      required String foto,
      required String telefone});

  ContatosModel.update(this._objectId, this._nome, this._sobrenome,
      this._status, this._foto, this._telefone);

  ContatosModel.create(
    this._nome,
    this._sobrenome,
    this._status,
    this._foto,
    this._telefone,
  );

  String get objectId => _objectId;
  set objectId(String objectId) => _objectId = objectId;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get sobrenome => _sobrenome;
  set sobrenome(String sobrenome) => _sobrenome = sobrenome;
  String get status => _status;
  set status(String status) => _status = status;
  String get foto => _foto;
  set foto(String foto) => _foto = foto;
  String get telefone => _telefone;
  set telefone(String telefone) => _telefone = telefone;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  ContatosModel.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _nome = json['nome'];
    _sobrenome = json['sobrenome'];
    _status = json['status'];
    _foto = json['foto'];
    _telefone = json['telefone'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['nome'] = _nome;
    data['sobrenome'] = _sobrenome;
    data['status'] = _status;
    data['foto'] = _foto;
    data['telefone'] = _telefone;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['nome'] = _nome;
    data['sobrenome'] = _sobrenome;
    data['status'] = _status;
    data['foto'] = _foto;
    data['telefone'] = _telefone;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }
}
