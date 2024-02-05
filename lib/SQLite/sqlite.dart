
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_auth/Models/note_model.dart';
import 'package:user_auth/Models/users.dart';


class DatabaseHelper {
  final databaseName = "note.db";
  String noteTable = "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  String userTable = "create table users (userId INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE, password TEXT)";

  Future<Database> initDB() async{
    final databsePath = await getDatabasesPath();
    final path = join(databsePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(noteTable);
      await db.execute(userTable);

    });
  }

  //login method 
  Future<bool> login(User user) async {
    final Database db = await initDB();
    var result = await db.rawQuery("select * from users where username = '${user.username}' AND password = '${user.password}'");
    if(result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //signup method 
  Future<int> signup(User user) async {
    final Database db = await initDB();

    return db.insert("users", user.toMap());

  }


    //Search Note Method
  Future<List<NoteModel>> searchNote(String keyword) async {
    final Database db = await initDB();
     List<Map<String, Object?>> result = await db.rawQuery("select * from notes where noteTitle LIKE ?", ["%$keyword%"]);
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  //Crud methods

  // Create Note
  Future<int> createNote(NoteModel noteModel) async {
    final Database db = await initDB();
    return db.insert('notes', noteModel.toMap());
  }

  //Get Note
  Future<List<NoteModel>> getNotes() async{
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  //Delete Note 
  Future<int> deleteNote(int id) async{
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  //Update Note
  Future<int> updateNote(title, content, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate('update notes set noteTitle = ?, noteContent = ?', [title, content, noteId]);
  }


}