class User {
  late final int? id;
  final String name;
  final String nickname;
  final String? email;
  final String? image;
  final String? token;

  User({
    required this.id, 
    required this.name, 
    required this.nickname, 
    required this.email,
    this.image,
    required this.token});

  static User fromMap(Map<String, dynamic> map) => User(
    id:  map['id'], 
    name: map['name'], 
    nickname: map['nickname'], 
    email: map['email'],
    image: map['image'],
    token: map['token']
  );

  Map<String, dynamic> toMap() =>  <String, dynamic>{
    "id": id,
    "name": name,
    "email": email,
    "nickname": nickname,
    "image": image,
    "token": token
  };
}