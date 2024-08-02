import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrando novo Site/App")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
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
              margin: EdgeInsets.only(top: 20),
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
                margin: EdgeInsets.only(top: 20),
                child: ListTile(
                  subtitle: TextField(
                      controller: pwd,
                      decoration: InputDecoration(
                          label: const Text("Senha"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 4)))),
                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
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
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                onPressed: () {},
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
