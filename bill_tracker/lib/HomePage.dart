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
                    //TODO NAO TA A DAR WAIT !!!!!!!!!!!!!!!!!!!!!1
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
                                    // use container to change width and height
                                    //height: 0.3*(MediaQuery.of(context).size.height),
                                    width: 0.3*(MediaQuery.of(context).size.width), //mudar para proporcianal a screen size
                                    child: Column(
                                      children: <Widget>[
                                        DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (value == null || value.isEmpty || value == "Categoria") {
                                              return 'Categoria não foi selecionada';
                                            }
                                            return null;
                                          },
                                          isExpanded: true,
                                          value: categoriaSelected,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.blue),
                                          onChanged: (String? value) {
                                            setState(() {
                                              categoriaSelected = value!;
                                            });
                                          },
                                          items: categoria
                                              .map<DropdownMenuItem<String>>(
                                                  (String? value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value!),
                                                );
                                              }).toList(),
                                        ),
                                        DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (value == null || value.isEmpty || value == "Sub-Categoria") {
                                              return 'Sub-Categoria não foi selecionada';
                                            }
                                            return null;
                                          },
                                          isExpanded: true,
                                          value: subcategoriaSelected,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.blue),
                                          onChanged: (String? value) {
                                            setState(() {
                                              subcategoriaSelected = value!;
                                            });
                                          },
                                          items: subcategoria
                                              .map<DropdownMenuItem<String>>(
                                                  (String? value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value!),
                                                );
                                              }).toList(),
                                        ),
                                        DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (value == null || value.isEmpty || value == "Nome") {
                                              return 'Nome não foi selecionado';
                                            }
                                            return null;
                                          },
                                          isExpanded: true,
                                          value: userSelected,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.blue),
                                          onChanged: (String? value) {
                                            setState(() {
                                              userSelected = value!;
                                            });
                                          },
                                          items: user
                                              .map<DropdownMenuItem<String>>(
                                                  (String? value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value!),
                                                );
                                              }).toList(),
                                        ),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'O Valor não foi preenchido';
                                            }else{
                                              try{
                                                double.parse(value);
                                              }on Exception{
                                                return 'O Valor não é um número';
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
                                            if (value == null || value.isEmpty) {
                                              return 'Designação não foi preenchida';
                                            }
                                            return null;
                                          },
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(
                                            labelText: 'Designação',
                                            icon: Icon(Icons.description),
                                          ),
                                        ),
                                        TextFormField(
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(
                                            labelText: 'Observações',
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
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Adicionado com sucesso',textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),backgroundColor: Colors.green,));
                                        Navigator.of(context, rootNavigator: true).pop();
                                      }
                                      },
                                    style: TextButton.styleFrom(padding: const EdgeInsets.all(20)),
                                    child: const Text("Adicionar", style: TextStyle(fontSize: 16)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true).pop();
                                    },
                                  style: TextButton.styleFrom(padding: const EdgeInsets.all(20)),
                                    child: const Text("Cancelar", style: TextStyle(fontSize: 16)),
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
                    //    //inserir autenticação aqui
                    //    context,
                    //    MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: const Text(
                    'Consultar Despesas do Mês',
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
                    //    //inserir autenticação aqui
                    //    context,
                    //    MaterialPageRoute(builder: (_) => HomePage()));
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
        "SELECT nome FROM user WHERE accountID='$widget.accID';");
    for (final row in result.rows){
      user.add(row.toString());
    }
    var result2 = await conn.execute(
        "select nome, id, null from categoria where accountID = '$widget.accID' UNION select nome as nome2, null, id as id2 from subcategoria where categoriaID = categoriaid");
    for (final row in result2.rows){
      if(row.colByName("id") != "null"){
        categoria.add(row.colByName("nome"));
        String? id = row.colByName("id");
        for(final row in result2.rows) {
          if (row.colByName("NULL") == id) {
            subcategoria.add(row.colByName("nome"));
          }
        }
      }
    }
  }
}
