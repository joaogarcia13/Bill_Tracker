import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'HomePage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late String accID;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Center(
                child: SizedBox(
                    width: 150,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/login-icon.png',
                        fit: BoxFit.contain)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 15, bottom: 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O Username não foi preenchido';
                  }
                  return null;
                },
                controller: usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Introduza o seu Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 15, bottom: 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A Password não foi preenchida';
                  }
                  return null;
                },
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Introduza a sua Password'),
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
                onHover: (hasFocus) {
                 setState(() {
                   if(hasFocus){
                      color: Colors.pink;
                    }else{
                     color: Colors.green;
                   }
                 });
                 //muda a cor do botao mas nao funciona
                },
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool access = await loginQuery();
                    if (!mounted) return;
                    if (access == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage(accID)));
                    }else{
                      //TODO crash here
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Adicionado com sucesso',textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),backgroundColor: Colors.green,));
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

  Future<bool> loginQuery() async {
    final conn = await MySQLConnection.createConnection(
      host: dotenv.env['host'],
      port: int.parse(dotenv.env['port']!),
      userName: dotenv.env['username'].toString(),
      password: dotenv.env['password'].toString(),
      databaseName: dotenv.env['databaseName'], // optional
    );
    await conn.connect();

    var user = usernameController.text;
    var pass = passController.text;
    //TODO vuneravel a injecao sql
    //TODO Hash/salt password
    var result = await conn.execute(
        "SELECT * FROM account WHERE username='$user' and password='$pass';");
    if(result.rows.length == 1){
      for (final row in result.rows) {
        accID = row.colByName("id")!;
      }
    }

    conn.close();
    return result.rows.length == 1;
  }
}
