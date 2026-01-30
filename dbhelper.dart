import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), 'todo.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todo(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );

    return _db!;
  }

  // INSERT
  static Future<void> insertTodo(My_model todo) async {
    final db = await getDatabase();
    await db.insert('todo', todo.toJson());
    print('added');
  }

  // UPDATE
  static Future<void> updateTodo(My_model todo) async {
    final db = await getDatabase();
    await db
        .update('todo', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);

    print('updated');
  }

  // READ
  static Future<List<My_model>> getTodos() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> data = await db.query('todo');

    return data.map((e) => My_model.frommap(e)).toList();
  }

  // DELETE
  static Future<void> deleteTodo(int id) async {
    final db = await getDatabase();
    await db.delete('todo', where: 'id = ?', whereArgs: [id]);
    print('deleted');
  }
}
