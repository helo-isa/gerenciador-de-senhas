import 'package:flutter/material.dart';
import 'package:gerenciador_senhas/database/db.dart';
import 'package:gerenciador_senhas/model/sa.dart';
import 'package:sqflite/sqflite.dart';

Future<int> insertSA(SiteApp siteApp) async {
  Database db = await getDatabase();
  return db.insert('SA', siteApp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, dynamic>>> findall(String table) async {
  Database db = await getDatabase();
  List<Map<String, dynamic>> dados = await db.query(table);
  return dados;
}

Future<int> deleteById(int id) async {
  debugPrint('Deletando o Id: $id');
  Database db = await getDatabase();
  return db.delete('SA', where: "id = ?", whereArgs: [id]);
}

Future<int> deleteAll() async {
  Database db = await getDatabase();
  return db.delete('SA');
}

Future<int> insertAesKey(String aesKey) async {
  Database db = await getDatabase();

  Map<String, dynamic> chave = {
    'key': aesKey,
  };
  return await db.insert('aesKey', chave,
      conflictAlgorithm: ConflictAlgorithm.replace);
}
