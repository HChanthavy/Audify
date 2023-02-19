import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:http/http.dart';

import '../models/export_models.dart';

class HttpService {
  var client = http.Client();
  final String baseUrl = "https://audify-music.cyclic.app/api";

  // Validate Token
  // Future<dynamic> validateToken(String? token) async {
  //   try {
  //     Response res = await client.get(
  //       Uri.parse("$baseUrl/user/login"),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     print(res.body);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Fetch User's Playlist
  Future<List<Song>> getPlaylists(String user) async {
    Response res = await client.get(Uri.parse("$baseUrl/user"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];
        body =
            body.firstWhere((element) => element['name'] == user)['playlists'];

        List<Song> users =
            body.map((dynamic item) => Song.fromJson(item)).toList();

        return users;
      } else {
        throw "Cannot get playlists.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch User's Liked Song
  Future<List<Song>> getLikedSongs(String user) async {
    Response res = await client.get(Uri.parse("$baseUrl/user"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];
        body =
            body.firstWhere((element) => element['name'] == user)['likedSongs'];

        List<Song> users =
            body.map((dynamic item) => Song.fromJson(item)).toList();

        return users;
      } else {
        throw "Cannot get liked songs.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Json File of Liked Songs
  Future<List> getJsonLikedSongs(String user) async {
    Response res = await client.get(Uri.parse("$baseUrl/user"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];
        body =
            body.firstWhere((element) => element['name'] == user)['likedSongs'];
        return body;
      } else {
        throw "Cannot get json file liked songs.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch length of liked songs
  Future<int> getLengthLikedSongs(String user) async {
    Response res = await client.get(Uri.parse("$baseUrl/user"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];
        body =
            body.firstWhere((element) => element['name'] == user)['likedSongs'];

        return body.length;
      } else {
        throw "Cannot get json file liked songs.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Add Liked Song
  Future<dynamic> addLikedSong(
      dynamic id,
      List<dynamic> currentList,
      String name,
      String imageURL,
      String songURL,
      String artist,
      String language,
      String category) async {
    try {
      var input = {
        'name': name,
        'imageURL': imageURL,
        'songURL': songURL,
        'artist': artist,
        'language': language,
        'category': category
      };
      Response res = await client.put(
        Uri.parse("$baseUrl/user/$id"),
        headers: {'Content-Type': 'application/json'},
        body: currentList.isNotEmpty
            ? json.encode({
                'data': {
                  'likedSongs': [
                    for (int i = 0; i < currentList.length; i++) currentList[i],
                    input
                  ]
                }
              })
            : json.encode({
                'data': {
                  'likedSongs': [input]
                }
              }),
      );
      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw "Cannot add to liked songs";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Remove Liked Song
  Future<dynamic> removeLikedSong(
      dynamic id, List<dynamic> currentList, String songName) async {
    currentList.removeWhere((element) => element['name'] == songName);

    try {
      Response res = await client.put(Uri.parse("$baseUrl/user/$id"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "data": {"likedSongs": currentList}
          }));
      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw 'Cannot remove from liked songs';
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch User
  dynamic getUserId(String user) async {
    Response res = await client.get(Uri.parse("$baseUrl/user"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];
        String userId =
            body.firstWhere((element) => element['name'] == user)['_id'];

        return userId;
      } else {
        throw "Cannot get id user.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Songs
  Future<List<Song>> getAllSongs() async {
    Response res = await client.get(Uri.parse("$baseUrl/song"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];

        List<Song> songs =
            body.map((dynamic item) => Song.fromJson(item)).toList();

        return songs;
      } else {
        throw "Cannot get all songs.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Random Song
  Future<List<Song>> getRandomSongs() async {
    Response res = await get(Uri.parse("$baseUrl/song"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];
        body.shuffle();

        List<Song> songs =
            body.map((dynamic item) => Song.fromJson(item)).toList();

        return songs;
      } else {
        throw "Cannot get random songs.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Recently Added Song
  Future<List<Song>> getCurrentlyAdded() async {
    Response res = await get(Uri.parse("$baseUrl/song"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];
        body = body.reversed.toList();

        List<Song> songs =
            body.map((dynamic item) => Song.fromJson(item)).toList();

        return songs;
      } else {
        throw "Cannot get currently added songs.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Songs as Json File
  Future<List<Song>> getSongsSearch({String? query}) async {
    Response res = await get(Uri.parse("$baseUrl/song"));

    try {
      if (res.statusCode == 200) {
        List<dynamic> body = [jsonDecode(res.body)][0]["data"];
        List<Song> songs =
            body.map((dynamic item) => Song.fromJson(item)).toList();
        if (query != null) {
          songs = songs
              .where((item) =>
                  item.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        return songs;
      } else {
        throw "Cannot get search songs.";
      }
    } catch (e) {
      rethrow;
    }
  }
}
