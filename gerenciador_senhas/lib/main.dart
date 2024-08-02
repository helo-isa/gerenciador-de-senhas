import 'package:flutter/material.dart';
import 'package:gerenciador_senhas/model/sa.dart';
import 'package:gerenciador_senhas/pages/new.dart';

import 'pages/visualizar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController user = TextEditingController();

  TextEditingController pwd = TextEditingController();

  Map c_login = {"default": "1"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login")),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(60, 200, 60, 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 20),
              child: TextField(
                  controller: user,
                  decoration: InputDecoration(
                      label: const Text("Digite seu nome de Usuario"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 4)))),
            ),
            TextField(
                controller: pwd,
                obscureText: true,
                decoration: InputDecoration(
                    label: const Text("Digite sua Senha"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 4)))),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 35),
                      backgroundColor: Colors.blue[300]),
                  onPressed: () {
                    if (user.text != "" && pwd.text != "") {
                      if (c_login.containsKey(user.text)) {
                        if (c_login[user.text] == pwd.text) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PasswordManager(),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Senha incorreta para o usuário ${user.text}'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Usuário ${user.text} não encontrado'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha todos os campos'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class PasswordManager extends StatefulWidget {
  @override
  State<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {
  final List<Map> sites = [
    SiteApp(
            id: 1,
            user: "Heitor",
            password: '1111110',
            url: 'gov.com.br',
            obs: null)
        .toMap()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: const Text('Gerenciador de Senhas')),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => add_new_sa(),
                    ));
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sites e Apps',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: sites.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1))),
                    child: ListTile(
                        title: Text(sites[index]["url"]),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    visualizar(item: sites[index]),
                              ));
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
