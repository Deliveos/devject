import 'package:devject/models/user.dart';
import 'package:devject/services/database.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider {
  static final DatabaseProvider _provider = DatabaseProvider.instance;

  static Future create(User user) async {
    Database db = await _provider.database;
    return await db.rawQuery('''
    INSERT INTO user(id, name, nickname, email, token)
    VALUES(${user.id}, '${user.name}', '${user.nickname}', '${user.email}', '${user.token}');
    ''');
  }

  static Future<User?> get() async {
    Database db = await _provider.database;
    List result = (await db.rawQuery('''
    SELECT * FROM user;
    '''));
    if (result.isNotEmpty) {
      return User(
        id: result[0]['id'], 
        name: result[0]['name'], 
        nickname: result[0]['nickname'], 
        email: result[0]['email'], 
        image: result[0]['image'],
        token: result[0]['token']
      );
    }
    return null;
  }

  static Future update(User user) async {
    Database db = await _provider.database;
    return db.rawUpdate('''
      UPDATE user SET 
        name='${user.name}', 
        nickname='${user.nickname}',
        email='${user.email}',
        image='${user.image}',
        token='${user.token}'
    ''');
  }

  static Future delete() async {
    Database db = await _provider.database;
    return await db.rawQuery('''
    DELETE FROM user;
    ''');
  }
}