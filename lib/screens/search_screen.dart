import 'package:audify/screens/export_screens.dart';
import 'package:audify/widgets/export_widgets.dart';
import 'package:flutter/material.dart';

import '../globle/variable.dart';
import '../models/export_models.dart';
import '../service/http_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    // AudioPlayer audioPlayer = AudioPlayer();
    HttpService httpService = HttpService();

    // Future<List> allSongList = httpService.getJson();
    // // List<Song> displayList = List.from(allSongList as Iterable);
    // print('db' + allSongList.toString());

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
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Search',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.width * 0.025),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black.withOpacity(0.8)),
                        prefixIcon: Icon(
                          Icons.search,
                          size: MediaQuery.of(context).size.width * 0.06,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                      ),
                      onTap: () {
                        showSearch(context: context, delegate: Search());
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: FutureBuilder<List<Song>>(
                      future: httpService.getSongsSearch(),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
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
                                  // playSong(song.songURL);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => NowPlayingScreen(
                                        song: songs![index],
                                        audioPlayer: audioPlayer,
                                      ),
                                    ),
                                  );
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => DisplayScreens()
                                  //   ),
                                  // );
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
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

// ListTile(
//                                     key: ValueKey(song),
//                                     contentPadding: const EdgeInsets.all(0),
//                                     leading: SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.1,
//                                       child: Container(
//                                         alignment: Alignment.topCenter,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.1,
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.15,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15.0),
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                               song.imageURL,
//                                             ),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     title: Text(
//                                       song.name,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .titleSmall!
//                                           .copyWith(
//                                               fontWeight: FontWeight.bold),
//                                     ),
//                                     subtitle: Text(
//                                       song.artist,
//                                       style:
//                                           Theme.of(context).textTheme.bodySmall,
//                                     ),
//                                     onTap: () {
//                                       // playSong(song.songURL);
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               NowPlayingScreen(
//                                             song: song,
//                                             audioPlayer: audioPlayer,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
