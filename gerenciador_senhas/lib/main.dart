import 'package:flutter/material.dart';
import 'package:gerenciador_senhas/model/sa.dart';

import 'pages/visualizar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordManager(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class PasswordManager extends StatelessWidget {
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
        title: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: const Text('Gerenciador de Senhas')),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: IconButton(
              iconSize: 40,
              icon: const Icon(Icons.add),
              onPressed: () {},
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
                Container(
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
