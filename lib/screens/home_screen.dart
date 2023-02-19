import 'package:audify/globle/variable.dart';
import 'package:audify/screens/now_playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

import 'package:audify/service/http_service.dart';
import 'package:audify/widgets/export_widgets.dart';
import 'package:audify/models/export_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String firstname = user.displayName!.split(" ").first;

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Welcome back, $firstname',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.028,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.05,
                  backgroundImage: NetworkImage(user.photoURL!),
                  backgroundColor: Colors.grey.shade400,
                ),
                InkWell(
                  child: Container(
                      margin: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: FaIcon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        size: MediaQuery.of(context).size.width * 0.045,
                      )),
                  onTap: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);

                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey.shade100,
                            title: Text(
                              'Confirm Logout',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                              'Are you sure you want to log out?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  provider.logout();
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _MusicSection(
                  title: 'Trending',
                  httpService: httpService,
                  audioPlayer: audioPlayer,
                ),
                _RecommendationSection(
                  title: 'Recently added',
                  httpService: httpService,
                  audioPlayer: audioPlayer,
                ),
                _MusicSection(
                  title: 'Recommended for you',
                  httpService: httpService,
                  audioPlayer: audioPlayer,
                ),
                _MusicSection(
                  title: 'Most people listen to',
                  httpService: httpService,
                  audioPlayer: audioPlayer,
                ),
                _RandomSection(
                  title: "Feel Random?",
                  httpService: httpService,
                  audioPlayer: audioPlayer,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MusicSection extends StatelessWidget {
  const _MusicSection({
    required this.title,
    required this.httpService,
    required this.audioPlayer,
  });

  final String title;
  final HttpService httpService;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,

            // Fetching Song Data
            child: FutureBuilder(
              future: httpService.getAllSongs(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
                if (snapshot.hasData) {
                  List<Song>? songs = snapshot.data;

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: songs!
                        .map((Song song) => Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => NowPlayingScreen(
                                          song: song,
                                          audioPlayer: audioPlayer,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    margin: const EdgeInsets.only(right: 20.0),
                                    child: SizedBox(
                                      child: Stack(children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.23,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                song.imageURL,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.23),
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.37,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                song.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                song.artist,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                )
                              ],
                            ))
                        .toList(),
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
        ],
      ),
    );
  }
}

class _RecommendationSection extends StatelessWidget {
  const _RecommendationSection({
    required this.title,
    required this.httpService,
    required this.audioPlayer,
  });

  final String title;
  final HttpService httpService;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,

            // Fetching Song Data
            child: FutureBuilder(
              future: httpService.getCurrentlyAdded(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
                if (snapshot.hasData) {
                  List<Song>? songs = snapshot.data;

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: songs!
                        .map(
                          (Song song) => Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => NowPlayingScreen(
                                        song: song,
                                        audioPlayer: audioPlayer,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  margin: const EdgeInsets.only(right: 20.0),
                                  child: SizedBox(
                                    child: Stack(
                                      children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.23,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                song.imageURL,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.23),
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.37,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                song.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                song.artist,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
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
        ],
      ),
    );
  }
}

class _RandomSection extends StatelessWidget {
  const _RandomSection({
    required this.title,
    required this.httpService,
    required this.audioPlayer,
  });

  final String title;
  final HttpService httpService;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,

            // Fetching Song Data
            child: FutureBuilder(
              future: httpService.getRandomSongs(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
                if (snapshot.hasData) {
                  List<Song>? songs = snapshot.data;

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: songs!
                        .map((Song song) => Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => NowPlayingScreen(
                                          song: song,
                                          audioPlayer: audioPlayer,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    margin: const EdgeInsets.only(right: 20.0),
                                    child: SizedBox(
                                      child: Stack(children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.23,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.38,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                song.imageURL,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.23),
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.37,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                song.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                song.artist,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                )
                              ],
                            ))
                        .toList(),
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
        ],
      ),
    );
  }
}
