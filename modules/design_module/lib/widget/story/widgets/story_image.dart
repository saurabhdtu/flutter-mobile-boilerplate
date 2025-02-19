import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoryImage extends StatefulWidget {
  final String? imageUrl;
  final String? filePath;

  const StoryImage({
    Key? key,
    this.imageUrl,
    this.filePath,
  }) : super(key: key);

  factory StoryImage.url(String url) {
    return StoryImage(imageUrl: url);
  }

  factory StoryImage.file(String filePath) {
    return StoryImage(filePath: filePath);
  }

  @override
  State<StoryImage> createState() => _StoryImageState();
}

class _StoryImageState extends State<StoryImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: widget.filePath != null
            ? Image.file(
                File(widget.filePath!),
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: "${widget.imageUrl}",
                fit: BoxFit.cover,
              ));
  }
}
