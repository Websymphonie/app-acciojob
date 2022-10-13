import 'package:acciojob/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoLoader extends StatefulWidget {
  const CustomVideoLoader({Key? key}) : super(key: key);

  @override
  State<CustomVideoLoader> createState() => _CustomVideoLoaderState();
}

class _CustomVideoLoaderState extends State<CustomVideoLoader> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/files/video.mov')
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);
    _playVideo();
  }

  void _playVideo() async {
    _controller.play();
    await Future.delayed(const Duration(seconds: 6));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.whiteColor,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
    );
  }
}
