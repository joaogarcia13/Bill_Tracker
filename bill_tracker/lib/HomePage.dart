import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
        body: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                height: 50,
                width: 300,
                margin: const EdgeInsets.only(
                    left: 50, right: 50, top: 15, bottom: 15),
                child: TextButton(
                  //onHover: (hasFocus) {
                  // setState(() {
                  //   hasFocus ? Colors.pink : Colors.green;
                  // });
                  // muda a cor do botao mas nao funciona
                  //},
                  onPressed: () {
                    Navigator.push(
                      //inserir autenticação aqui
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: const Text(
                    'Adicionar Despesa',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                height: 50,
                width: 300,
                margin: const EdgeInsets.only(
                    left: 50, right: 50, top: 15, bottom: 15),
                child: TextButton(
                  //onHover: (hasFocus) {
                  // setState(() {
                  //   hasFocus ? Colors.pink : Colors.green;
                  // });
                  // muda a cor do botao mas nao funciona
                  //},
                  onPressed: () {
                    Navigator.push(
                      //inserir autenticação aqui
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: const Text(
                    'Consultar Despesas do Mês',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                height: 50,
                width: 300,
                margin: const EdgeInsets.only(
                    left: 50, right: 50, top: 15, bottom: 15),
                child: TextButton(
                  //onHover: (hasFocus) {
                  // setState(() {
                  //   hasFocus ? Colors.pink : Colors.green;
                  // });
                  // muda a cor do botao mas nao funciona
                  //},
                  onPressed: () {
                    Navigator.push(
                      //inserir autenticação aqui
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: const Text(
                    'Definições ????',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Container(//ROW 2
                  color: Colors.white,
                  padding: const EdgeInsets.all(20.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.black),
                    children: const [
                      TableRow(children: [
                        Text('Cell 1'),
                        Text('Cell 2'),
                        Text('Cell 3'),
                      ]),
                      TableRow(children: [
                        Text('Cell 4'),
                        Text('Cell 5'),
                        Text('Cell 6'),
                      ])
                    ],
                  ),
                )
              ]),
      );
  }
}