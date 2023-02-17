import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globle/variable.dart';
import '../models/export_models.dart';
import '../screens/export_screens.dart';
import '../service/http_service.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      hintColor: Colors.white,
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme.apply(
            fontSizeFactor: MediaQuery.of(context).size.width * 0.002,
            bodyColor: Colors.grey.shade100,
            displayColor: Colors.grey.shade100,
          )),
      // splashColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      // hoverColor: Colors.transparent,
      // textTheme: GoogleFonts.poppinsTextTheme(
      //   Theme.of(context).textTheme.apply(
      //         bodyColor: Colors.grey.shade100,
      //         displayColor: Colors.grey.shade100,
      //         fontSizeFactor: 0.8,
      //         decoration: TextDecoration.none,
      //       ),
      // ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleSpacing: 0,
        color: Colors.black.withOpacity(0.88),
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query != ""
          ? TextButton(
              onPressed: () {
                query = "";
              },
              child: Text(
                'Clear',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          : TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Icon(
      Icons.search,
      size: MediaQuery.of(context).size.width * 0.05,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    HttpService httpService = HttpService();
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.88),
                Colors.black,
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.width * 0.025),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<Song>>(
              future: httpService.getSongsSearch(query: query),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
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
                            height: MediaQuery.of(context).size.height * 0.1,
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
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04),
                        ),
                        subtitle: Text(
                          '${songs?[index].artist}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () {
                          Navigator.pop(context);
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
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.green.shade600,
                  ));
                } else {
                  return const Center(child: Text('Not Found'),);
                }
              },
            ),
          ),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    HttpService httpService = HttpService();
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.88),
                Colors.black,
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.width * 0.025),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<Song>>(
              future: httpService.getAllSongs(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
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
                            height: MediaQuery.of(context).size.height * 0.1,
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
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04),
                        ),
                        subtitle: Text(
                          '${songs?[index].artist}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          // playSong(song.songURL);
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
                ));
              },
            ),
          ),
        ));
  }
}
