library murmurer.data;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final String dbName;
late final String dbFilePath;
late final Database db;
late final SharedPreferences prefs;

const bool inProduction = const bool.fromEnvironment("dart.vm.product");// 判断是否处于生产模式

/// 初始化
Future<void> init(){
  return Future(() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getKeys().contains("dbName"))
      dbName = prefs.getString("dbName");
    else{
      dbName = "data.db";
      prefs.setString("dbName", "data.db");
    }

    var dbPath = await getDatabasesPath();
    dbFilePath = join(dbPath, dbName);

    if (!inProduction) {
      // 删除数据库
      await deleteDatabase(dbFilePath);
    }

    // 打开数据库
    db = await openDatabase(
      dbFilePath, version: 1,
      onCreate: (Database db, int version) async {
      // 创建表
      await db.execute("CREATE TABLE sentence("
        "id INTEGER PRIMARY KEY,"
        "content TEXT,"
        "created_time TIMESTAMP default (datetime('now', 'localtime')))");
      await db.execute("CREATE TABLE diary("
        "id INTEGER PRIMARY KEY,"
        "title TEXT,"
        "content TEXT,"
        "created_time TIMESTAMP default (datetime('now', 'localtime')))");
    });
});}

/// 添加一句话
void addASentence(String content) {
  db.insert("sentence", {"content": content});
}

/// 添加一篇日记
void addADiary(String title, String content)
{
  db.insert("diary", {"title": title, "content": content});
}

// 获取所有句子
Future<List<Map<String, dynamic>>> getSentences()
async {
  return await db.query("sentence");
}

// 获取所有日记
Future<List<Map<String, dynamic>>> getDiaries()
async {
  return await db.query("diary");
}

/// 删除一篇日记
void deleteADiary(int id){
  db.delete("diary", where: "id = $id");
}

/// 删除一句话
void deleteASentence(int id){
  db.delete("sentence", where: "id = $id");
}

/// 关闭数据库
void close() async {
  await db.close();
}
