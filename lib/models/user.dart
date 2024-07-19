import 'dart:convert';

class User {
  final int? id;
  final String username;
  String password;
  String rights;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.rights,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'rights': rights,
    };
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      rights: map['rights'] ?? '',
    );
  }

  String toMap() => json.encode(toJson());
}