import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciador_senhas/database/dao/dao.dart';
import 'package:gerenciador_senhas/main.dart';
import 'package:gerenciador_senhas/pages/edit.dart';

class visualizar extends StatefulWidget {
  final Map item;
  bool obscure;
  visualizar({required this.item, this.obscure = true});

  @override
  State<visualizar> createState() => _visualizarState();
}

class _visualizarState extends State<visualizar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['url']),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(50, 10, 50, 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(5)),
              child: ListTile(
                title: const Text(
                  "Nome de usuário",
                  style: TextStyle(color: Color.fromARGB(204, 0, 0, 0)),
                ),
                subtitle: Text(
                  widget.item['user'],
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.item['user']))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Copiado para a área de transferência')),
                      );
                    });
                  },
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Senha",
                              style: TextStyle(
                                  color: Color.fromARGB(204, 0, 0, 0)),
                            ),
                            TextField(
                              obscureText: widget.obscure,
                              controller: TextEditingController(
                                text: widget.item['password'],
                              ),
                              enabled: false,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(widget.obscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        setState(() {
                          widget.obscure = !widget.obscure;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                                ClipboardData(text: widget.item['password']))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Copiado para a área de transferência')),
                          );
                        });
                      },
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(5)),
              child: ListTile(
                title: const Text(
                  "Observação",
                  style: TextStyle(color: Color.fromARGB(204, 0, 0, 0)),
                ),
                subtitle: Text(
                  (widget.item['obs'] == null ? "" : widget.item['obs']),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => edit(item: widget.item),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 35),
                        backgroundColor: Colors.blue[300]),
                    child: const Text(
                      "Editar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      deleteById(widget.item["id"]);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 35),
                        backgroundColor: Colors.blue[300]),
                    child: const Text(
                      "Excluir",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
