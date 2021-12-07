import 'package:sqflite/sqflite.dart';
import 'package:todo_getx/models/task.dart';

class DBHelper{
  static Database db;
  static final int version =1;
  static final String tableName = "task";

  static Future<void> initDB() async {
    if(db != null){
      return;
    }
    try{
      String path = await getDatabasesPath() + 'task.db';
      db = await openDatabase(path,
          version: version,
          onCreate: (db,version){
            return db.execute(
              "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING,note STRING,date STRING,startTime STRING,endTime STRING,remind INTEGER, repeat STRING,color INTEGER,isCompleted INTEGER)",
            );

          });
    }catch(e){print(e);}
  }

  static Future<int> insert(Task task) async{
    print("insert function called");
    return await db.insert(tableName, task.toJson());
  }
}