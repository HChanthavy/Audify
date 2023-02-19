import 'package:audify/models/export_models.dart';
import 'package:audify/screens/export_screens.dart';
import 'package:flutter/material.dart';

import '../globle/variable.dart';

class LikedSongsScreen extends StatefulWidget {
  const LikedSongsScreen({super.key});

  @override
  State<LikedSongsScreen> createState() => _LikedSongsScreen();
}

class _LikedSongsScreen extends State<LikedSongsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.88),
              Colors.black,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Liked songs',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: FutureBuilder<List<Song>>(
                  future: httpService.getLikedSongs(user.displayName!),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Song>> snapshot) {
                    if (snapshot.hasData) {
                      List<Song>? songs = snapshot.data;

                      return ListView.builder(
                        itemCount: songs?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Container(
                                alignment: Alignment.topCenter,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${songs?[index].imageURL}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              '${songs?[index].name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${songs?[index].artist}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NowPlayingScreen(
                                    song: songs![index],
                                    audioPlayer: audioPlayer,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.green.shade600,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
