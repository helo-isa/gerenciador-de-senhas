import 'package:flutter/material.dart';
import 'package:gerenciador_senhas/database/dao/dao.dart';
import 'package:gerenciador_senhas/encrypting/aes.dart';
import 'package:gerenciador_senhas/model/sa.dart';
import 'package:gerenciador_senhas/pages/new.dart';

class edit extends StatefulWidget {
  final Map item;
  final AESHelper aesStart;
  edit({required this.item, required this.aesStart});
  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  late TextEditingController url;
  late TextEditingController user;
  late TextEditingController pwd;
  late TextEditingController obs;

  @override
  void initState() {
    super.initState();
    // Inicialize os controladores com os valores do item
    url = TextEditingController(text: widget.item['url']);
    user = TextEditingController(
        text: widget.aesStart.decrypt(widget.item['user']));
    pwd = TextEditingController(
        text: widget.aesStart.decrypt(widget.item['password']));
    obs = TextEditingController(text: widget.item['obs'] ?? '');
  }

  Widget build(BuildContext context) {
    // debugPrint();
    generateRandomString();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editando o Site/App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 55, 68, 112),
        toolbarHeight: 100.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 20),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: TextField(
                  controller: url,
                  decoration: InputDecoration(
                      label: const Text("URL"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 4)))),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: TextField(
                  controller: user,
                  decoration: InputDecoration(
                      label: const Text("Login"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 4)))),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: TextField(
                controller: pwd,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.casino),
                    onPressed: () {
                      setState(() {
                        pwd.text = generateRandomString();
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: TextField(
                  controller: obs,
                  decoration: InputDecoration(
                      label: const Text("Observação"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 4)))),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(80, 20, 80, 0),
              child: ElevatedButton(
                onPressed: () {
                  if (pwd.text == '' || user.text == '' || url.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha os campos obrigatorios'),
                      ),
                    );
                  } else {
                    insertSA(SiteApp(
                        id: widget.item['id'],
                        user: widget.aesStart.encrypt(user.text),
                        url: url.text,
                        password: widget.aesStart.encrypt(pwd.text),
                        obs: obs.text));
                    Navigator.pushNamed(context, '/main');
                  }
                },
                style: ElevatedButton.styleFrom(
                    // minimumSize: Size(20, 50),
                    // fixedSize: const Size(5, 5),
                    backgroundColor: Color.fromARGB(255, 72, 145, 111)),
                child: const Text(
                  "Salvar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
