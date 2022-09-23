import 'package:flutter/material.dart';

const List<String> list = <String>['Categoria', 'One', 'Two', 'Three', 'Four'];

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
          Align(
          alignment: AlignmentDirectional.center,
              child: OverflowBar(
                spacing: 1,
                overflowAlignment: OverflowBarAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                    height: 50,
                    width: 300,
                    margin: const EdgeInsets.only(
                        left: 40, right: 40, top: 15, bottom: 15),
                    child: TextButton(
                      //onHover: (hasFocus) {
                      // setState(() {
                      //   hasFocus ? Colors.pink : Colors.green;
                      // });
                      // muda a cor do botao mas nao funciona
                      //},
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Text('Adicionar Despesa'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Container( // use container to change width and height
                                    height: 200,
                                    width: 400,
                                      child: Column(
                                        children: <Widget>[
                                          const DropdownButtonExample(),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Email',
                                              icon: Icon(Icons.email),
                                            ),
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Message',
                                              icon: Icon(Icons.message ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    child: Text("Submit"),
                                      onPressed: () {
                                      // your code
                                      })
                              ],
                            );
                          });
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
                        left: 40, right: 40, top: 15, bottom: 15),
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
                        left: 40, right: 40, top: 15, bottom: 15),
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
          ),
          const Text(
            'Despesas Recentes',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
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

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}