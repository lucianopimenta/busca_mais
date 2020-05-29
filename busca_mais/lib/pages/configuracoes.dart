import 'package:buscamais/components/button.dart';
import 'package:buscamais/helper/helper.dart';
import 'package:buscamais/helper/prefs.dart';
import 'package:buscamais/model/cidadeModel.dart';
import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatefulWidget {
  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  CidadeModel itemSelecionado;
  List<CidadeModel> cidades = <CidadeModel>[
    CidadeModel(1, 'Barreiras'),
    CidadeModel(2, 'Luiz Eduardo'),
  ];

  @override
  void initState() {
    super.initState();
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
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
        children: [
          Text('Cidade de prefêrencia:', style: TextStyle(fontSize: 16,),),
          criaDropDownButton(),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: ButtonPrimary("Confirmar", () => _confirmar(context))
            ),
          )
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
              itemSelecionado = selected;
            });
          },
          value: itemSelecionado),
    );
  }

  _confirmar(BuildContext context) {
    if (itemSelecionado == null)
      DialogsHelper.messageDialog('Escolha uma cidade!', context);
    else {
      Prefs.setInt('cidade', itemSelecionado.codigo);
      DialogsHelper.messageDialog('Configuração salva com sucesso', context);
    }
  }

  void Load() {
    Prefs.getInt('cidade').then((int value) => {

      if (value > 0)

        setState(() {
          itemSelecionado = cidades.singleWhere((x) => x.codigo == value, orElse: () => null);
        })
    });

  }
}
