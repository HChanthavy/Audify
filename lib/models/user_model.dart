import 'dart:ffi';

class User {
  final String id;
  final String name;
  final String email;
  final String imageURL;
  // final String album;
  final String userId;
  final bool emailVerified;
  final String role;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.imageURL,
      // required this.album,
      required this.userId,
      required this.emailVerified,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    // print('name');
    // print(json["data"][0]['name']);
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      imageURL: json['imageURL'] as String,
      // album: json['album'] as Null,
      userId: json['user_id'] as String,
      emailVerified: json['email_verified'] as bool,
      role: json['role'] as String,
    );
  }
}
