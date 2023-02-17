
import 'package:mongo_dart/mongo_dart.dart';

void start() async {
  final db = await Db.create(
      "mongodb+srv://admin:Lz9TUpxjBfgwo7yC@cluster0.fbvules.mongodb.net/?retryWrites=true&w=majority");
  await db.open();
  final coll = db.collection('likedSongs');

  print(await coll.find().toList());

  const port = 4000;
  
}
