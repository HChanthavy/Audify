import 'package:audify/service/http_service.dart';
import 'package:audify/widgets/export_widgets.dart';
import 'package:flutter/material.dart';
import 'package:audify/models/export_models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen(
      {super.key, required this.song, required this.audioPlayer});
  final Song song;
  final AudioPlayer audioPlayer;

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  HttpService httpService = HttpService();
  bool _isLike = false;
  bool _isPlaying = false;
  int _isLooping = 0;
  bool _isShuffle = false;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '-:--';
    } else {
      String mintues = duration.inMinutes.toString().padLeft(1, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$mintues:$seconds';
    }
  }

  @override
  void initState() {
    super.initState();
    playSong();
  }

  void playSong() {
    try {
      widget.audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(widget.song.songURL),
        ),
      );
      widget.audioPlayer.play();
      _isPlaying = true;
    } catch (e) {
      widget.audioPlayer.play();
    }
    widget.audioPlayer.durationStream.listen(
      (duration) {
        if (mounted) {
          setState(
            () {
              _duration = duration!;
            },
          );
        }
      },
    );
    widget.audioPlayer.positionStream.listen(
      (position) {
        if (mounted) {
          setState(
            () {
              _position = position;
            },
          );
        }
      },
    );
  }

  // @override
  // void dispose() {
  //   widget.audioPlayer.dispose();
  //   super.dispose();
  // }

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
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  'Now Playing',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w100),
                ),
                Text(
                  '${widget.song.name} - ${widget.song.artist}',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.song.imageURL,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.white.withOpacity(0.6),
                                  size: 20,
                                )),
                            Column(
                              children: [
                                Text(
                                  widget.song.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.song.artist,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  var song = Song(
                                      name: widget.song.name,
                                      imageURL: widget.song.imageURL,
                                      songURL: widget.song.songURL,
                                      artist: widget.song.artist,
                                      language: widget.song.language,
                                      category: widget.song.category);
                                  print(song);
                                  

                                  _isLike = !_isLike;
                                  // if (_isLike) {
                                  //   httpService.addLikedSong(
                                  //       '/user/${widget.song.name}', song);
                                  // } else {}
                                },
                                icon: FaIcon(
                                  _isLike
                                      ? FontAwesomeIcons.solidHeart
                                      : FontAwesomeIcons.heart,
                                  color: _isLike
                                      ? Colors.green.shade600
                                      : Colors.white.withOpacity(0.6),
                                  size: 20,
                                )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.09,
                              child: Text(
                                _formatDuration(_position),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  overlayColor: Colors.transparent,
                                  trackHeight: 3,
                                  thumbShape: const RoundSliderThumbShape(
                                      disabledThumbRadius: 6,
                                      enabledThumbRadius: 6),
                                  activeTrackColor:
                                      Colors.green.shade600.withOpacity(0.8),
                                  inactiveTrackColor:
                                      Colors.white.withOpacity(0.2),
                                  thumbColor: Colors.green.shade600,
                                ),
                                child: Slider(
                                  min: const Duration(microseconds: 0)
                                      .inSeconds
                                      .toDouble(),
                                  value: _position.inSeconds.toDouble(),
                                  max: _duration.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      changeToSeconds(value.toInt());
                                      value = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.09,
                              child: Text(
                                _formatDuration(_duration),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          if (_isShuffle) {
                                            widget.audioPlayer
                                                .setShuffleModeEnabled(true);
                                          } else {
                                            widget.audioPlayer
                                                .setShuffleModeEnabled(false);
                                          }
                                          _isShuffle = !_isShuffle;
                                        },
                                      );
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.shuffle,
                                      color: _isShuffle
                                          ? Colors.white.withOpacity(1)
                                          : Colors.white.withOpacity(0.6),
                                      size: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.backwardStep,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          if (_isPlaying) {
                                            widget.audioPlayer.pause();
                                          } else {
                                            widget.audioPlayer.play();
                                          }
                                          _isPlaying = !_isPlaying;
                                        },
                                      );
                                    },
                                    icon: FaIcon(
                                      _isPlaying
                                          ? FontAwesomeIcons.pause
                                          : FontAwesomeIcons.play,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.forwardStep,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            if (_isLooping == 2) {
                                              // Lopp off
                                              widget.audioPlayer
                                                  .setLoopMode(LoopMode.off);
                                            } else if (_isLooping == 1) {
                                              // Loop one only
                                              widget.audioPlayer
                                                  .setLoopMode(LoopMode.one);
                                            } else {
                                              // Loop all
                                              widget.audioPlayer
                                                  .setLoopMode(LoopMode.all);
                                            }
                                            _isLooping += 1;
                                            _isLooping = _isLooping % 3;
                                          },
                                        );
                                      },
                                      icon: _isLooping == 1
                                          ? FaIcon(
                                              FontAwesomeIcons.repeat,
                                              color: Colors.white,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            )
                                          : _isLooping == 2
                                              ? Image.asset(
                                                  'assets/images/repeatOne.png',
                                                  color: Colors.white,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03,
                                                )
                                              : FaIcon(
                                                  FontAwesomeIcons.repeat,
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                )
                                      // FaIcon(
                                      //   FontAwesomeIcons.repeat,
                                      //   color: _isLooping == 1
                                      //       ? Colors.white.withOpacity(1)
                                      //       : Colors.white.withOpacity(0.6),

                                      ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.volumeLow,
                                  color: Colors.white.withOpacity(0.6),
                                  size:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                const VolumeBar(),
                                FaIcon(
                                  FontAwesomeIcons.volumeHigh,
                                  color: Colors.white.withOpacity(0.6),
                                  size:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}
