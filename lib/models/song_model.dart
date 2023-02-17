class Song {
  final String name;
  final String imageURL;
  final String songURL;
  // final String album;
  final String artist;
  final String language;
  final String category;

  Song(
      {required this.name,
      required this.imageURL,
      required this.songURL,
      // required this.album,
      required this.artist,
      required this.language,
      required this.category});

  factory Song.fromJson(Map<String, dynamic> json) {
    // print('name');
    // print(json["data"][0]['name']);
    return Song(
      name: json['name'] as String,
      imageURL: json['imageURL'] as String,
      songURL: json['songURL'] as String,
      // album: json['album'] as Null,
      artist: json['artist'] as String,
      language: json['language'] as String,
      category: json['category'] as String,
    );
  }

  factory Song.toJson(Map<String, dynamic> json) {
    return Song(
      name: json['name'] as String,
      imageURL: json['imageURL'] as String,
      songURL: json['songURL'] as String,
      // album: json['album'] as Null,
      artist: json['artist'] as String,
      language: json['language'] as String,
      category: json['category'] as String,
    );
  }
}
