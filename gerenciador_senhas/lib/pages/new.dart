import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerenciador_senhas/database/dao/dao.dart';
import 'dart:math';

import 'package:gerenciador_senhas/model/sa.dart';

String generateRandomString() {
  const String letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String allChars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  var random = Random();

  String randomString = letters[random.nextInt(letters.length)].toString();

  for (int i = 1; i < 8; i++) {
    randomString += allChars[random.nextInt(allChars.length)].toString();
  }

  List<int> charCodes = List.from(randomString.codeUnits);
  charCodes.shuffle(random);

  return randomString;
}

class add_new_sa extends StatefulWidget {
  @override
  State<add_new_sa> createState() => _add_new_saState();
}

class _add_new_saState extends State<add_new_sa> {
  TextEditingController url = TextEditingController();

  TextEditingController user = TextEditingController();

  TextEditingController pwd = TextEditingController();

  TextEditingController obs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    generateRandomString();
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastrando novo Site/App")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 20),
        child: Column(
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
                    icon: const Icon(Icons.abc),
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
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                        user: user.text,
                        url: url.text,
                        password: pwd.text,
                        obs: obs.text));
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 35),
                    backgroundColor: Colors.blue[300]),
                child: const Text(
                  "Cadastrar",
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
