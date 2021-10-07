import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';


class ProjetexApi {
  static const String _baseRoute = "http://192.168.0.109:5000/api";

  static String _createPath(String path) => _baseRoute + "/" + path;

  static Future<void> signUp(String name, String nickname, String password) async {
    final http.Response response = await http.post(
      Uri.parse(_createPath("users/register")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'nickname': nickname,
        'password': sha256.convert(utf8.encode(password)).toString()
      }),
    );
    if (jsonDecode(response.body)["token"] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", jsonDecode(response.body)["token"]);
    }
  }

  static Future<String?> signIn(String nickname, String password) async {
    final http.Response response = await http.post(
      Uri.parse(_createPath("users/login")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nickname': nickname,
        'password': sha256.convert(utf8.encode(password)).toString()
      }),
    );
    print(nickname);
    print(jsonDecode(response.body));
    String? token = jsonDecode(response.body)["token"];
    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);
      return token;
    }
    return null;
  }

  static Future<void> logout() async {

  }

  static Future<bool> checkForUser(String nickname) async {
    final http.Response response = await http.get(
      Uri.parse(_createPath("users?nickname=$nickname")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(jsonDecode(response.body)["message"] == "OK") {
      return true;
    }
    return false;
  }
}