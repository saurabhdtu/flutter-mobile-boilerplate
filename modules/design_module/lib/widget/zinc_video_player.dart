import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AutoPlayVideo extends StatefulWidget {
  final String? videoUrl;
  final String? videoFilePath;
  final bool? fileExists;

  const AutoPlayVideo(
      {Key? key,
      required this.videoUrl,
      required this.videoFilePath,
      required this.fileExists})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AutoPlayVideoState();
}

class _AutoPlayVideoState extends State<AutoPlayVideo> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.fileExists == true &&
        widget.videoFilePath != null &&
        widget.videoFilePath != "") {
      _controller = VideoPlayerController.file(File(widget.videoFilePath!))
        ..setLooping(true) // Optional: loop the video
        ..setVolume(1.0); // Optional: set the volume
      _initializeVideoPlayerFuture = _controller.initialize().then((_) {
        _controller.play(); // Auto play the video
      });
    } else {
      Uri uri = Uri.parse(widget.videoUrl!);
      _controller = VideoPlayerController.networkUrl(uri)
        ..setLooping(true) // Optional: loop the video
        ..setVolume(1.0); // Optional: set the volume
      _initializeVideoPlayerFuture = _controller.initialize().then((_) {
        _controller.play(); // Auto play the video
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
