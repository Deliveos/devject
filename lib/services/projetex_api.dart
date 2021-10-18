import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetex/models/project.dart';
import 'package:projetex/models/user.dart';
import 'package:projetex/providers/user_provider.dart';
import 'package:crypto/crypto.dart';


class ProjetexApi {
  static const String _baseRoute = "http://192.168.43.22:5000/api";

  static String _createPath(String path) => _baseRoute + "/" + path;

  static Future<String?> signUp(String name, String nickname, String password) async {
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
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body["id"] != null 
      && body["name"] != null
      && body["nickname"] != null
      && body["token"] != null
      ) {
      await UserProvider.create(User(id: body["id"], name: body["name"], nickname: body["nickname"], token: body["token"]));
    }
    return body["token"];
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
    Map<String, dynamic> body = jsonDecode(response.body);
    if (body["id"] != null 
      && body["name"] != null
      && body["nickname"] != null
      && body["token"] != null
      ) {
      UserProvider.create(User(id: body["id"], name: body["name"], nickname: body["nickname"], token: body["token"]));
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
        'Authorization': 'Bearer ' + user!.token
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
        'Authorization': 'Bearer ' + user!.token
      },
      body: project.toMap()
    );
  }

  // static Future<List<Responsible>?> getResponsible() {
  //   await http.post(
  //     Uri.parse(_createPath("projects")),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer ' + user!.token
  //     },
  //     body: project.toMap()
  //   );
  // }
}