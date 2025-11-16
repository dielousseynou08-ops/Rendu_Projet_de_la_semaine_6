import 'package:ronkhlab_agro/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDb {
  final databaseName = "mydb.db";

  String tableName = "users";

  String tableNote = "notes";

  //login
  Future<bool> login(Users user) async {
    final db = await initDB();
    var result = await db.rawQuery(
      "SELECT * FROM users WHERE usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'",
    );
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //sign up
  Future<int> signup(Users user) async {
    final db = await initDB();
    return db.insert("users", user.toMap());
  }

  Future<Database> initDB() async {
    //  await deleteDatabase(join(await getDatabasesPath(), "mydb.db"));
    final databasePath = await getDatabasesPath();

    // ignore: non_constant_identifier_names
    final Path = join(databasePath, databaseName);
    return openDatabase(
      Path,
      version: 1,
      onCreate: (db, version) async {
        // table users
        await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usrName TEXT NOT NULL,
      usrPassword TEXT NOT NULL
    )
  ''');
      },
    );
  }

  //insert

  Future<int> createNote(Users user) async {
    final db = await initDB();
    return await db.insert(
      "users",
      user.toMap(),

      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Users>> getUsers() async {
    final db = await initDB();
    List<Map<String, Object?>> result = await db.query("users");
    return result.map((e) => Users.fromMap(e)).toList();
  }

  Future<int> deleteUser(int? id) async {
    final db = await initDB();
    return await db.delete(tableNote, where: "noteId = ?", whereArgs: [id]);
  }

  Future<int> updateUser(userName, password, id) async {
    final db = await initDB();
    return await db.update(
      'users',
      {'usrName': userName, 'usrPassword': password},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
