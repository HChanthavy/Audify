import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:http/http.dart';

import '../models/export_models.dart';

class HttpService {
  var client = http.Client();
  final String baseUrl = "https://audify-music.cyclic.app/api";

  // var data = [];
  // List<Song> results = [];

  // Liked Song
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
        throw "Can't get songs.";
      }
    } catch (e) {
      rethrow;
    }
  }

  // Add Liked Song
  Future<dynamic> addLikedSong(String id) async {
    try {
      Response res = await client.post(
        Uri.parse("$baseUrl/user/$id"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': "Heng Chanthavy"}),
      );
      if (res.statusCode == 201) {
        print(res.body);
        return res.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  // }

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
        throw "Can't get songs.";
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
        throw "Can't get songs.";
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
        // print("Body");
        body = body.reversed.toList();

        List<Song> songs =
            body.map((dynamic item) => Song.fromJson(item)).toList();

        return songs;
      } else {
        throw "Can't get songs.";
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
        throw "Can't get songs.";
      }
    } catch (e) {
      rethrow;
    }
  }
}
