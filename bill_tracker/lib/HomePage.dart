import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {

  HomePage(this.accID, {super.key});
  String accID;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //TODO buscar a base de dados
  late List<String?> categoria = ["Categoria"];
  late List<String?> subcategoria = ["Sub-Categoria"];
  late List<String?> user = ["Nome"];
  late final List<List<String?>> subcat = [["-1", "Sub-Categoria"]];
  final Map<String?, String?> catID = HashMap();
  late String categoriaSelected;
  late String subcategoriaSelected;
  late String userSelected;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
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
                  onPressed: () async {
                    categoriaSelected = "Categoria";
                    subcategoriaSelected = "Sub-Categoria";
                    userSelected = "Nome";
                    categoria = ["Categoria"];
                    subcategoria = ["Sub-Categoria"];
                    user = ["Nome"];
                    await getArrayDB();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: const Text('Adicionar Despesa'),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: _formKey,
                                      child: Container(
                                        width: 0.3 * (MediaQuery
                                            .of(context)
                                            .size
                                            .width),
                                        //mudar para proporcianal a screen size
                                        child: Column(
                                          children: <Widget>[
                                            DropdownButtonFormField<String>(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value == "Categoria") {
                                                  return 'Categoria n??o foi selecionada';
                                                }
                                                return null;
                                              },
                                              isExpanded: true,
                                              value: categoriaSelected,
                                              icon: const Icon(
                                                  Icons.arrow_downward),
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                              onChanged: (String? value) async {
                                                setState(() {
                                                  categoriaSelected = value!;
                                                });
                                                if (categoriaSelected !="Categoria") {
                                                  //TODO e isto mas nao limpa o array
                                                  subcategoria = ["Sub-Categoria"];
                                                  catID.forEach((catid, catnome) {
                                                    if(catnome == categoriaSelected){
                                                      for (var List in subcat) {
                                                        if(List[0] == catid){
                                                          subcategoria.add(List[1]);
                                                        }
                                                      }
                                                    }
                                                  });
                                                }
                                              },
                                              items: categoria
                                                  .map<
                                                  DropdownMenuItem<String>>(
                                                      (String? value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value!),
                                                    );
                                                  }).toList(),
                                            ),
                                            DropdownButtonFormField<String>(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value == "Sub-Categoria") {
                                                  return 'Sub-Categoria n??o foi selecionada';
                                                }
                                                return null;
                                              },
                                              isExpanded: true,
                                              value: subcategoriaSelected,
                                              icon: const Icon(
                                                  Icons.arrow_downward),
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  subcategoriaSelected = value!;
                                                });
                                              },
                                              items: subcategoria
                                                  .map<
                                                  DropdownMenuItem<String>>(
                                                      (String? value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value!),
                                                    );
                                                  }).toList(),
                                            ),
                                            DropdownButtonFormField<String>(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    value == "Nome") {
                                                  return 'Nome n??o foi selecionado';
                                                }
                                                return null;
                                              },
                                              isExpanded: true,
                                              value: userSelected,
                                              icon: const Icon(
                                                  Icons.arrow_downward),
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  userSelected = value!;
                                                });
                                              },
                                              items: user
                                                  .map<
                                                  DropdownMenuItem<String>>(
                                                      (String? value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value!),
                                                    );
                                                  }).toList(),
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'O Valor n??o foi preenchido';
                                                } else {
                                                  try {
                                                    double.parse(value);
                                                  } on Exception {
                                                    return 'O Valor n??o ?? um n??mero';
                                                  }
                                                }
                                                return null;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                labelText: 'Valor',
                                                icon: Icon(Icons.euro),
                                              ),
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Designa????o n??o foi preenchida';
                                                }
                                                return null;
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                labelText: 'Designa????o',
                                                icon: Icon(Icons.description),
                                              ),
                                            ),
                                            TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: const InputDecoration(
                                                labelText: 'Observa????es',
                                                icon: Icon(Icons.message),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              const SnackBar(content: Text(
                                                  'Adicionado com sucesso',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 18)),
                                                backgroundColor: Colors
                                                    .green,));
                                          Navigator.of(
                                              context, rootNavigator: true)
                                              .pop();
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(20)),
                                      child: const Text("Adicionar",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                            context, rootNavigator: true).pop();
                                      },
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(20)),
                                      child: const Text("Cancelar",
                                          style: TextStyle(fontSize: 16)),
                                    )
                                  ],
                                );
                              });
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
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
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
                    //Navigator.push(
                    //    //inserir autentica????o aqui
                    //    context,
                    //    MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: const Text(
                    'Consultar Despesas do M??s',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
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
                    //Navigator.push(
                    //    //inserir autentica????o aqui
                    //    context,
                    //    MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: const Text(
                    'Defini????es ????',
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
        Container(
          //ROW 2
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

  Future<void> getArrayDB() async {
    final conn = await MySQLConnection.createConnection(
      host: dotenv.env['host'],
      port: int.parse(dotenv.env['port']!),
      userName: dotenv.env['username'].toString(),
      password: dotenv.env['password'].toString(),
      databaseName: dotenv.env['databaseName'], // optional
    );
    await conn.connect();

    var result = await conn.execute(
        "SELECT nome FROM user WHERE accountID='${widget.accID}';");
    for (final row in result.rows) {
      user.add(row.colByName("nome"));
    }
    var result2 = await conn.execute(
        "select nome,id from categoria where accountID = ${widget.accID}");
    for (final row in result2.rows) {
      categoria.add(row.colByName("nome"));
      catID.addAll({row.colByName("id"): row.colByName("nome")});
    }
    var result3 = await conn.execute(
        "select subcategoria.nome, subcategoria.categoriaID from subcategoria left join categoria d on subcategoria.categoriaID = d.id where accountID = 1");
    for (final row in result3.rows) {
     //subcatID.addAll({row.colByName("nome") : row.colByName("categoriaID")});
      subcat.add([row.colByName("categoriaID"),row.colByName("nome")]);
    }
    conn.close();
  }
}

