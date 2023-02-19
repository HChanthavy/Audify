import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SignInBackground extends StatefulWidget {
  const SignInBackground({super.key});

  @override
  State<SignInBackground> createState() => _SignInBackgroundState();
}

class _SignInBackgroundState extends State<SignInBackground> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Spectrum1.mp4')
      ..initialize().then(
        (_) {
          _controller.setVolume(0.0);
          _controller.setLooping(true);
          _controller.play();
          setState(() {});
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
