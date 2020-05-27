class CategoriaModel {
  int codigo;
  int codigoPai;
  String nome;
  String icone;
  List<CategoriaModel> filhos;

  CategoriaModel(
      {this.codigo, this.codigoPai, this.nome, this.icone, this.filhos});

  CategoriaModel.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    codigoPai = json['codigoPai'];
    nome = json['nome'];
    icone = json['icone'];

    if (json['filhos'] != null) {
      filhos = new List<CategoriaModel>();
      json['filhos'].forEach((v) {
        filhos.add(new CategoriaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['codigoPai'] = this.codigoPai;
    data['nome'] = this.nome;
    data['icone'] = this.icone;
    if (this.filhos != null) {
      data['filhos'] = this.filhos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}