import 'dart:ffi';

class User {
  final String id;
  final String name;
  final String email;
  final String imageURL;
  final String userId;
  final Array likedSong;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.imageURL,
      required this.userId,
      required this.likedSong});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      imageURL: json['imageURL'] as String,
      userId: json['user_id'] as String,
      likedSong: json['likedSong'] as Array,
    );
  }
}
