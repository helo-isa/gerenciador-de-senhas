import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> deleteDatabaseFile() async {
  String caminhoBanco = join(await getDatabasesPath(), 'bancodnv.db');
  await deleteDatabase(caminhoBanco);
}

Future<Database> getDatabase() async {
  String caminhoBanco = join(await getDatabasesPath(), 'bancodnv.db');

  return openDatabase(
    caminhoBanco,
    version: 2, // Atualize a versão do banco de dados
    onCreate: (db, version) async {
      await db.execute('CREATE TABLE SA('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'user TEXT, '
          'url TEXT, '
          'password TEXT, '
          'obs TEXT) ');
      await db.execute('''
        CREATE TABLE aesKey(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          key TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE hash(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user TEXT,
          pass TEXT
        )
      ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        // Atualiza a versão do banco de dados e recria a tabela aesKey
        await db.execute('''
        CREATE TABLE aesKey(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          key TEXT
        )
      ''');
        await db.execute('''
          CREATE TABLE hash(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user TEXT,
            pass TEXT
          )
        ''');
      }
    },
  );
}
