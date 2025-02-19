import 'dart:io';

import 'package:utility_module/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StoryLottie extends StatefulWidget {
  final String? url;
  final String? filePath;

  const StoryLottie({
    Key? key,
    this.url,
    this.filePath,
  }) : super(key: key);

  factory StoryLottie.url(String url) {
    return StoryLottie(url: url);
  }

  factory StoryLottie.file(String filePath) {
    return StoryLottie(filePath: filePath);
  }

  @override
  State<StoryLottie> createState() => _StoryLottieState();
}

class _StoryLottieState extends State<StoryLottie> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: widget.filePath.isEmptyOrNull()
            ? Lottie.network(widget.url!, animate: true, repeat: true)
            : Lottie.file(File(widget.filePath!), animate: true, repeat: true));
  }
}
