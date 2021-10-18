class User {
  final int id;
  final String name;
  final String nickname;
  final String token;

  User({
    required this.id, 
    required this.name, 
    required this.nickname, 
    required this.token});

  static User fromMap(Map<String, dynamic> map) => User(
    id:  map['id'], 
    name: map['name'], 
    nickname: map['nickname'], 
    token: map['token']
  );

  Map<String, dynamic> toMap() =>  <String, dynamic>{
    "id": id,
    "name": name,
    "nickname": nickname,
    "token": token
  };
}