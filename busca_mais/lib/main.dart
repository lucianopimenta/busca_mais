import 'dart:convert';
import 'package:buscamais/components/button.dart';
import 'package:buscamais/helper/navigation.dart';
import 'package:buscamais/model/categoriaModel.dart';
import 'package:buscamais/model/cidadeModel.dart';
import 'package:buscamais/model/favoritoModel.dart';
import 'package:buscamais/pages/configuracoes.dart';
import 'package:buscamais/pages/telefonesuteis.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/material.dart';
import 'package:buscamais/helper/extensions.dart';

import 'helper/prefs.dart';
import 'model/dataModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuscaMais',
      theme: ThemeData(
        primaryColor: '#2196f3'.toColor(),
        primaryColorDark: '#0d47a1'.toColor(),
        accentColor: 'FF4081'.toColor(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Busca Mais'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  CidadeModel itemSelecionado;
  List<CidadeModel> cidades = <CidadeModel>[
    CidadeModel(1, 'Barreiras'),
    CidadeModel(2, 'Luiz Eduardo'),
  ];
  List<FavoritoModel> favoritoItems = <FavoritoModel>[
    FavoritoModel(1, '2A Materiais Elétricos', DateTime.now()),
    FavoritoModel(2, 'Dr. Informática', DateTime.now()),
    FavoritoModel(3, 'Serralheria Cupim', DateTime.now()),
  ];
  List<CategoriaModel> categorias = <CategoriaModel>[];

  @override
  void initState() {
    super.initState();
    Load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: _drawer(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                busca(),
                cidade(),
                ButtonPrimary("Busca", () => print('Busca pelo texto e cidade')),
                SizedBox(height: 16,),
                Text('Busca pela categoria'),
                treeViewCategorias(),
                ButtonPrimary("Busca por Categoria", () => print('Busca pelo texto e cidade')),
                SizedBox(height: 16,),
                favoritos(),
              ],
            ),
        ),
      ),
    );
  }

  _drawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            height: 150,
            child: Row(
              children: [
                Image.asset('assets/images/logo.png')
              ],
            ),
          ),
          ListTile(
            title: Text("Histórico"),
            subtitle: Text("Histórico de empresas visualizadas"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Telefones úteis"),
            subtitle: Text("Telefones úteis por cidade"),
            onTap: () {
              Navigator.pop(context);
              openPage(context, TelefoneUtil(), replace: false);
            },
          ),
          ListTile(
            title: Text("Configurações"),
            subtitle: Text("Configurações do aplicativo"),
            onTap: () {
              Navigator.pop(context);
              openPage(context, ConfiguracoesPage(), replace: false); 
              
            },
          ),
          ListTile(
            title: Text("Compartilhar"),
            subtitle: Text('Envie para seus amigos o Busca Mais'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Sobre"),
            subtitle: Text('Mais informações do aplicativo'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
}

  busca() {
    return TextField(
        controller: searchController,
        decoration: InputDecoration(
            labelText: "O que você busca?",
            hintText: "Digite o texto para busca",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
    );
  }

  void Load() async {
    //cidade
    Prefs.getInt('cidade').then((int value) => {
      if (value > 0)

        setState(() {
          itemSelecionado = cidades.singleWhere((x) => x.codigo == value, orElse: () => null);
        })
    });

    //categorias
    await DefaultAssetBundle.of(context).loadString("assets/data/categoria").then((value) => {
      setState(() {
        List lista = json.decode(value);
//        for(Map map in lista){
//          CategoriaModel categoria = CategoriaModel.fromJson(map);
//          categorias.add(categoria);
//        }
        categorias = lista.map((x) => CategoriaModel.fromJson(x)).toList();
      })
    });
  }

  cidade() {
    return DropdownButton<CidadeModel>(
      hint: Text('Escolha uma cidade'),
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
          value: itemSelecionado);
    }

  treeViewCategorias() {
    return Column(
        children: [
          SizedBox(height: 70,),
          Text('TreeView', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
//          DynamicTreeView(
//            width: double.infinity,
//              data: getData(),
//              config: Config(
//                arrowIcon: Icon(Icons.arrow_right),
//                parentTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                parentPaddingEdgeInsets: EdgeInsets.only(left: 16, top: 0, bottom: 0)),
//              ),
          SizedBox(height: 70,),
        ],
    );
  }

  favoritos() {
    return Card(
      elevation: 10,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow,),
                    SizedBox(width: 7,),
                    Text('Favoritos', style: TextStyle(fontSize: 20, color: Colors.blue),),
                  ],
                ),
              ),
              Padding(
                    padding: EdgeInsets.symmetric(horizontal:16.0, vertical: 0.0),
                    child:Container(
                      height:1.5,
                      width: double.infinity,
                      color:Colors.blue,),),
              CarouselSlider(
                items: favoritoItems.map((imageLink) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16),
                          child:
                            Column(
                              children: [
                                Image.asset("assets/images/icon.png", fit: BoxFit.fill, height: 100, width: 100,),
                                SizedBox(height: 7,),
                                Text(imageLink.nome)
                              ],
                            ));
                    },
                  );
                }).toList(),
                reverse: false, //is false by default (reverses the order of items)
                enableInfiniteScroll: true, //is true by default (it scrolls back to item 1 after the last item)
                autoPlay: true, //is false by default
                initialPage: 0, //allows you to set the first item to be displayed
                scrollDirection: Axis.horizontal, //can be set to Axis.vertical
                pauseAutoPlayOnTouch: Duration(seconds: 5), //it pauses the sliding if carousel is touched,
                onPageChanged: (int pageNumber) {
                  //this triggers everytime a slide changes
                },
                viewportFraction: 0.8,
                enlargeCenterPage: true, //is false by default
                aspectRatio: 16 / 9, //if height is not specified, then this value is used
              )
            ],
          )
        ],
      ),
    );
  }

  List<BaseData> getData() {
    var data = categorias;
    var lista = List<BaseData>();
    for(var categoria in data){
      //cria o item
      var item = DataModel(
          id: categoria.codigo,
          parentId: categoria.codigoPai == null ? -1 : categoria.codigoPai,
          name: categoria.nome,
          icone: categoria.icone,
          extras: null);
      lista.add(item);
      //verifica se tem filhos
      if (categoria.filhos.length > 0)
        lista.addAll(incluirFilhos(categoria.codigo, categoria.filhos));
    }

    return lista;
  }

  incluirFilhos(categoriaPai, List<CategoriaModel> lista){
    var data = List<BaseData>();

    for(var categoria in lista){
      var item = DataModel(
          id: categoria.codigo,
          parentId: categoriaPai,
          name: categoria.nome,
          icone: categoria.icone,
          extras: null);
        data.add(item);
      }
    return data;
  }
}
