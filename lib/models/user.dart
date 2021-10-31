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

  User copyWith({
    int? id, 
    String? name,
    String? nickname,
    String? email,
    String? image,
    String? token
  }) {
    return User(
      id: id ?? this.id, 
      name: name ?? this.name, 
      nickname: nickname ?? this.nickname, 
      email: email ?? this.email,
      image: image ?? this.image,
      token: token ?? this.token
    );
  }
}