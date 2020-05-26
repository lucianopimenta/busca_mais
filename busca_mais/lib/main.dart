import 'package:buscamais/helper/navigation.dart';
import 'package:buscamais/pages/configuracoes.dart';
import 'package:flutter/material.dart';
import 'package:buscamais/helper/extensions.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: _drawer(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
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
  }
