import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:devject/models/project.dart';
import 'package:devject/models/user.dart';
import 'package:devject/providers/user_provider.dart';


class API {
  static const String _baseRoute = "http://192.168.43.22:5000/api";

  static String _createPath(String path) => _baseRoute + "/" + path;

  static Future<String?> signUp(String name, String nickname, String email, String password) async {
    final http.Response response = await http.post(
      Uri.parse(_createPath("users/register")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'nickname': nickname,
        'email': email,
        'password': password
      }),
    ); 
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body["id"] != null 
      && body["name"] != null
      && body["nickname"] != null
      && body["email"] != null
      && body["token"] != null
      ) {
      await UserProvider.create(User(id: body["id"], name: body["name"], nickname: body["nickname"], email: body["email"], token: body["token"]));
    }
    return body["token"];
  }

  static Future<String?> signInByNickname(String nickname, String password) async {
    final http.Response response = await http.post(
      Uri.parse(_createPath("users/login")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nickname': nickname,
        'password': password
      }),
    );
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body["id"] != null 
      && body["name"] != null
      && body["nickname"] != null
      && body["token"] != null
      ) {
      UserProvider.create(User(id: body["id"], name: body["name"], nickname: body["nickname"], email: body["email"], token: body["token"]));
    }
    return body["token"];
  }

  static Future<String?> signInByEmail(String email, String password) async {
    final http.Response response = await http.post(
      Uri.parse(_createPath("users/login")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password
      }),
    );
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body["id"] != null 
      && body["name"] != null
      && body["nickname"] != null
      && body["token"] != null
      ) {
      UserProvider.create(User(id: body["id"], name: body["name"], nickname: body["nickname"], email: body["email"], token: body["token"]));
    }
    return body["token"];
  }

  static Future<void> logout() async {
    await UserProvider.delete();
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

  static Future<List<Project>> getAllProjects() async {
    User? user = await UserProvider.get();
    final http.Response response = await http.get(
      Uri.parse(_createPath("projects")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + user!.token!
      },
    );
    List<Project> projects = [];
    Map body = jsonDecode(response.body);    
    for (var project in body['projects']) {
      projects.add(Project.fromMap(project));
    }
    return projects;
  }

  static Future<void> addProject(Project project) async {
    User? user = await UserProvider.get();
    await http.post(
      Uri.parse(_createPath("projects")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + user!.token!
      },
      body: jsonEncode(project.toMap())
    );
  }

  static Future<List<User>> searchUserByNickname(String nickname) async {
    User? user = await UserProvider.get();
    final http.Response response = await http.get(
      Uri.parse(_createPath("users/search?nickname=$nickname")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + user!.token!
      }
    );
    List<User> users = [];
    Map body = jsonDecode(response.body);
    for (var user in body['users']) {
      users.add(User.fromMap(user));
    }
    return users.isNotEmpty ? users : [];
  }
}