import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gerenciador_senhas/database/dao/dao.dart';
import 'package:gerenciador_senhas/encrypting/aes.dart';
import 'package:gerenciador_senhas/encrypting/hash.dart';
import 'package:gerenciador_senhas/model/sa.dart';
import 'package:gerenciador_senhas/pages/new.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'pages/visualizar.dart';

AESHelper? aesStart;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  debugPrint((await findall("SA")).toString());
  insertHash(generateHash('default'), generateHash('123'));

  // deleteAll();
  // Gera uma chave aleatória em Base64
  String aesKey = generateRandomKeyAsBase64(32);
  await insertAesKey(aesKey); // Atualize a chamada da função
  debugPrint((await findall("aesKey")).toString());
  debugPrint((await findall("hash"))[0]['user'].toString());

  // testechaveglobal = (await findall("aesKey"))[0]['key'] as String;
  aesStart = AESHelper((await findall("aesKey"))![0]['key']
      as String); // Inicializa o aes com a chave do banco

  // var x = aesStart!.encrypt("Meu testeeeeeee asdsdasds adssa");
  // debugPrint("texto criptografado $x");
  // debugPrint("texto normal ${aesStart!.decrypt(x)}");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => login(),
        '/main': (context) => PasswordManager(),
      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 55, 68, 112),
          toolbarHeight: 100.0,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 60, 60, 20),
              child: Column(
                children: [
                  const Text(
                    "Para acessar suas senhas, faça login",
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                    child: TextField(
                        controller: user,
                        decoration: InputDecoration(
                            label: const Text("Digite seu nome de Usuario"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 55, 68, 112),
                                    width: 4)))),
                  ),
                  TextField(
                      controller: pwd,
                      obscureText: true,
                      decoration: InputDecoration(
                          label: const Text("Digite sua Senha"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 55, 68, 112),
                                  width: 4)))),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 35),
                            backgroundColor:
                                const Color.fromARGB(255, 55, 68, 112)),
                        onPressed: () async {
                          Map c_login = {
                            (await findall("hash"))[0]['user'].toString():
                                (await findall("hash"))[0]['pass'].toString()
                          };
                          if (user.text != "" && pwd.text != "") {
                            if (c_login.containsKey(generateHash(user.text))) {
                              if (c_login[generateHash(user.text)] ==
                                  generateHash(pwd.text)) {
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
                                  content: Text(
                                      'Usuário ${user.text} não encontrado'),
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
          ],
        ));
  }
}

class PasswordManager extends StatefulWidget {
  @override
  State<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {
  TextEditingController pesquisarcontroller = TextEditingController();
  void pesquisar() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Adiciona um listener para chamar a função pesquisar sempre que o texto mudar
    pesquisarcontroller.addListener(pesquisar);
  }

  @override
  void dispose() {
    // Remove o listener ao descartar o controlador
    pesquisarcontroller.removeListener(pesquisar);
    pesquisarcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 55, 68, 112),
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 100.0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Gerenciador de Senhas',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: IconButton(
              iconSize: 40,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => add_new_sa(),
                    )).then((value) {
                  setState(() {});
                });
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
                SearchBar(
                  controller: pesquisarcontroller,
                  onChanged: pesquisar,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                initialData: [],
                future: findall("SA"),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: Text(
                            'Houve um erro de conexão com o banco de dados'),
                      );
                    case ConnectionState.waiting:
                    // fez a requisição e estou esperando a resposta
                    case ConnectionState.active:
                      // active mostra que a conexão com o banco foi bem sucedida
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.done:
                      // o que mostro na tela quando a conexão terminar
                      List<Map> sites = snapshot.data as List<Map>;
                      String query = pesquisarcontroller.text.toLowerCase();
                      List<Map> filteredSites = sites.where((site) {
                        String url = site["url"].toLowerCase();
                        return url.contains(query);
                      }).toList();
                      return ListView.builder(
                        itemCount: filteredSites.length,
                        itemBuilder: (context, index) {
                          Map item = filteredSites[index];
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            child: ListTile(
                              title: Hero(
                                tag: 'expansion_${item['id']}',
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          0, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      item["url"],
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => visualizar(
                                      item: item,
                                      aesStart: aesStart,
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;

  const SearchBar({required this.controller, required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 45,
      child: TextField(
        controller: controller,
        onChanged: (value) => onChanged(),
        decoration: InputDecoration(
          hintText: 'Pesquisar',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
