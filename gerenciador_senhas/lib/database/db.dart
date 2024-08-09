import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> deleteDatabaseFile() async {
  String caminhoBanco = join(await getDatabasesPath(), 'SA.db');
  await deleteDatabase(caminhoBanco);
}

Future<Database> getDatabase() async {
  String caminhoBanco = join(await getDatabasesPath(), 'SiteAPP.db');

  return openDatabase(
    caminhoBanco,
    version: 1,
    onCreate: (db, version) {
      db.execute('CREATE TABLE SA('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'user TEXT, '
          'url TEXT, '
          'password TEXT, '
          'obs TEXT) ');
    },
  );
}
