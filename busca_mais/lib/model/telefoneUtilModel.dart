class TelefoneUtilModel {
  int codigo;
  int codigoCidade;
  String cidade;
  String descricao;
  String numero;

  TelefoneUtilModel(
      {this.codigo, this.codigoCidade, this.cidade, this.descricao, this.numero});

  TelefoneUtilModel.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    codigoCidade = json['codigoCidade'];
    cidade = json['cidade'];
    descricao = json['descricao'];
    numero = json['numero'];
  }
}