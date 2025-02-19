import 'package:common_module/model/faq_support.dart';
import 'package:design_module/widget/zinc_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';

class FullscreenVideoPlayer extends StatefulWidget {
  final Video video;

  FullscreenVideoPlayer({required this.video});

  @override
  _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.url))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _isPlaying = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZincScaffold.scaffold(
      showHelp: false,
      leadingIcon: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: GestureDetector(
          child: zincFlutterIcon(Icons.close,
              size: 25,
              iconColor: Colors.black,
              bgColor: const Color.fromARGB(255, 231, 229, 229)),
          onTap: () {
            context.pop();
          },
        ),
      ),
      context,
      '',
      Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                    _isPlaying = !_controller.value.isPlaying;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: widget.video.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    if (!_isPlaying)
                      Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 80,
                      ),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
            _isPlaying = _controller.value.isPlaying;
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
