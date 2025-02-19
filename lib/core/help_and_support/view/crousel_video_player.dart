import 'package:common_module/model/faq_support.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';
import 'package:zinc/core/help_and_support/view/full_screen_video_player.dart';

class VideoCarousel extends StatefulWidget {
  final List<Video> videos;

  VideoCarousel({required this.videos});

  @override
  _VideoCarouselState createState() => _VideoCarouselState();
}

class _VideoCarouselState extends State<VideoCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.videos.length,
        itemBuilder: (context, index) {
          final video = widget.videos[index];
          return SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              FullscreenVideoPlayer(
                            video: video,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset(0.0, 0.0);
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: video.aspectRatio,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: ZincImage.networkAsset(
                              imageUrl: video.thumbnail,
                              imageWidth: double.infinity,
                              imageHeight: double.infinity,
                              fit: BoxFit.cover,
                              isCircle: false,
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.black,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    video.title,
                    style: ZincTextStyle.normalBold(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
