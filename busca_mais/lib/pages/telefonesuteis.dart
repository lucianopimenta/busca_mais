import 'dart:convert';
import 'package:buscamais/helper/prefs.dart';
import 'package:buscamais/model/cidadeModel.dart';
import 'package:buscamais/model/telefoneUtilModel.dart';
import 'package:flutter/material.dart';

class TelefoneUtil extends StatefulWidget {
  @override
  _TelefoneUtilState createState() => _TelefoneUtilState();
}

class _TelefoneUtilState extends State<TelefoneUtil> {
  CidadeModel cidade;
  List<CidadeModel> cidades = <CidadeModel>[
    CidadeModel(1, 'Barreiras'),
    CidadeModel(2, 'Luiz Eduardo'),
  ];
  List<TelefoneUtilModel> telefones = <TelefoneUtilModel>[];

  @override
  void initState() {
    super.initState();
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telefones úteis'),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('Escolha a cidade:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          criaDropDownButton(),
          criaListView()
        ],
      ),
    );
  }

  criaDropDownButton() {
    return Container(
      child: DropdownButton<CidadeModel>(
          items: cidades.map((CidadeModel item) {
            return DropdownMenuItem<CidadeModel>(
              value: item,
              child: Text(item.nome),
            );
          }).toList(),
          onChanged: (CidadeModel selected) {
            setState(() {
              cidade = selected;
            });
          },
          value: cidade),
    );
  }

  void Load() async {
    Prefs.getInt('cidade').then((int value) => {

      if (value > 0)

        setState(() {
          cidade = cidades.singleWhere((x) => x.codigo == value, orElse: () => null);
        })
    });

    await DefaultAssetBundle.of(context).loadString("assets/data/telefones").then((value) => {
      setState(() {
        List lista = json.decode(value);
        telefones = lista.map((x) => TelefoneUtilModel.fromJson(x)).toList();
      })
    });

  }

  criaListView() {

    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
            itemCount: telefones.length,
            itemBuilder: (context, index){
              var telefone = telefones[index];
              return ListTile(
                title: Text(telefone.descricao, style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(telefone.numero),
                trailing: Icon(Icons.phone, color: Colors.blue,),
                onTap: () {
                    print('Ligar');
                },
              );
        }),
    );
  }
}
