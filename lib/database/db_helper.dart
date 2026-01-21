import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'gaming_hub.db');
    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE playtime(id INTEGER PRIMARY KEY, gameName TEXT, startTime TEXT, duration INTEGER)",
      );
    });
  }

  static Future<void> saveSession(String name, int durationMinutes) async {
    final db = await initDB();
    await db.insert('playtime', {
      'gameName': name,
      'startTime': DateTime.now().toString(),
      'duration': durationMinutes,
    });
  }
}
