import 'package:projetex/models/user.dart';
import 'package:projetex/services/database.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider {
  static final DatabaseProvider _provider = DatabaseProvider.instance;

  static Future<User?> get() async {
    Database db = await _provider.database;
    List result = (await db.rawQuery('''
    SELECT * FROM user;
    '''));
    if (result.isNotEmpty) {
      return User(id: result[0]['id'], name: result[0]['name'], nickname: result[0]['nickname'], token: result[0]['token']);
    }
    return null;
  }

  static Future create(User user) async {
    Database db = await _provider.database;
    return await db.rawQuery('''
    INSERT INTO user(id, name, nickname, token)
    VALUES(${user.id}, '${user.name}', '${user.nickname}', '${user.token}');
    ''');
  }

  static Future delete() async {
    Database db = await _provider.database;
    return await db.rawQuery('''
    DELETE FROM user;
    ''');
  }
}