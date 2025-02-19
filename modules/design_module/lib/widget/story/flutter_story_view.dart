import 'dart:async';
import 'dart:io';

import 'package:design_module/widget/story/models/story_item.dart';
import 'package:design_module/widget/story/widgets/story_image.dart';
import 'package:design_module/widget/story/widgets/story_indicator.dart';
import 'package:design_module/widget/story/widgets/story_lottie.dart';
import 'package:design_module/widget/story/widgets/story_video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// A StatefulWidget that displays a series of story items with a customizable
/// progress indicator and user-defined callback functions for navigation and
/// completion events.
///
/// The `FlutterStoryView` takes a list of `StoryItem` objects, and displays them
/// one at a time, advancing to the next item after a specified duration.
///
/// The widget also provides a set of callback functions that can be used to
/// handle user interactions, such as tapping on the screen to pause, resume,
/// or navigate between story items.
///
/// The `onComplete` callback is triggered when all items have been displayed,
/// while the `onPageChanged` callback is triggered every time the currently
/// displayed item changes.

/// [OnPageChanged] is called when a story item changes
typedef OnPageChanged(int);

class FlutterStoryView extends StatefulWidget {
  /// This Calls when story is completed
  final VoidCallback onComplete;

  /// [OnPageChanged] is called when a story item changes
  final OnPageChanged onPageChanged;

  final List<StoryItem> storyItems;

  final double? indicatorHeight;

  // Background color of indicator
  final Color? indicatorColor;

  // Background color of indicator
  final Color? indicatorValueColor;

  final bool? enableOnHoldHide;

  // Reply button text
  // Padding of indicator
  final EdgeInsets? indicatorPadding;
  final Widget? headerRightActionWidget;

  final double contentBorderRadius;

  FlutterStoryView({
    required this.onComplete,
    required this.onPageChanged,
    required this.storyItems,
    this.indicatorHeight,
    this.indicatorColor,
    this.headerRightActionWidget,
    this.indicatorValueColor,
    this.enableOnHoldHide = true,
    this.indicatorPadding = const EdgeInsets.only(top: 40.0),
    this.contentBorderRadius = 0,
  });

  @override
  _FlutterStoryViewState createState() => _FlutterStoryViewState();
}

class _FlutterStoryViewState extends State<FlutterStoryView>
    with TickerProviderStateMixin {
  /// Main Controller
  AnimationController? _animationController;
  VideoPlayerController? _videoController;
  Animation<double>? _animation;

  /// current story item index
  int currentItemIndex = 0;

  /// current progress
  double _progress = 0;

  /// This [_tapDownTime] to indicate how long the story is being hold on finger
  /// so that we can easily find out to resume timer or switch to the next page.
  DateTime? _tapDownTime;

  /// This [_timer] is used to determine if the onTapDown is holded for 200 milliseconds
  /// long or less than this. So that we can find out to go to Next story or
  /// just hide the top and bottom menu on hold.
  Timer? _timer;

  bool _isVideoLoading = false;

  bool _isPaused = false;

  @override
  void initState() {
    super.initState();

    /// Start playing the story by calling _playStory method
    _playStory(currentItemIndex);
    // Notify the onPageChanged callback about the current item index
    widget.onPageChanged(currentItemIndex);
  }

  // Start playing the story at the given index
  void _playStory(int index) {
    /// If story is video
    var story = widget.storyItems[index];

    if (story.type == StoryItemType.video) {
      /// Dispose the previous _videoController (if any) before initializing new one.
      _videoController?.dispose();

      setState(() {
        _isVideoLoading = true; // Set loading to true when video starts loading
      });
      // Check if the URL is an asset or a network URL

      _videoController = story.fileExists
          ? VideoPlayerController.file(File(story.filePath!))
          : VideoPlayerController.networkUrl(Uri.parse(story.url!));

      _videoController!
        ..initialize().then((_) {
          setState(() {
            _isVideoLoading = false;
            _isPaused = false;
          });
          _videoController!.play();

          // Limit video duration to 30 seconds
          if (_videoController!.value.duration.inSeconds > 30) {
            _videoController!.setLooping(false); // Disable looping
            Timer(const Duration(seconds: 30), () {
              _onAnimationCompleted();
              _videoController!.pause();
            });
          } else {
            _videoController!.setLooping(true); // Enable looping
          }

          Duration clampedDuration =
              _videoController!.value.duration.inSeconds > 30
                  ? const Duration(seconds: 30)
                  : _videoController!.value.duration;
          _startAnimation(index, duration: clampedDuration);
        });
    } else {
      _startAnimation(index); // Pass index without video duration
    }
  }

  void _startAnimation(int index, {Duration? duration}) {
    Duration storyDuration =
        duration ?? Duration(seconds: widget.storyItems[index].duration!);

    _animationController = AnimationController(
      vsync: this,
      duration: storyDuration,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        setState(() {
          _progress = _animation!.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _onAnimationCompleted();
        }
      });

    setState(() {
      _progress = 0.0; // Set progress to 0 before starting the animation
    });

    _animationController!.forward();
  }

  // Handles the completion of the story animation
  void _onAnimationCompleted() {
    if (currentItemIndex == widget.storyItems.length - 1) {
      widget.onComplete();
    } else {
      currentItemIndex++;
      widget.onPageChanged(currentItemIndex);
      setState(() {
        _progress =
            0.0; // Reset progress value to 0 when the story automatically advances
      });
      _playStory(currentItemIndex);
    }
  }

  // Handles tap action to go to the next story item
  void _onTapNext() {
    // To prevent moving to the next story if the video is still loading
    if (_isVideoLoading) return;

    if (currentItemIndex == widget.storyItems.length - 1) {
      widget.onComplete();
    } else {
      currentItemIndex++;
      widget.onPageChanged(currentItemIndex);
      _animationController!.dispose();
      setState(() {
        _progress = 0.0; // Reset progress value to 0 when tapping next
      });
      _playStory(currentItemIndex);
    }
  }

  // Handles tap action to go to the previous story item
  void _onTapPrevious() {
    if (currentItemIndex == 0) {
      // You can perform something here :)
    } else {
      currentItemIndex--;
      widget.onPageChanged(currentItemIndex);
      _animationController!.dispose();
      setState(() {
        _progress = 0.0; // Reset progress value to 0 when tapping next
      });
      _playStory(currentItemIndex);
    }
  }

  // Pause the story timer
  void _pauseTimer() {
    _animationController!.stop();
    _videoController?.pause();
    setState(() {});
  }

  // Resume the story timer
  void _resumeTimer() {
    _animationController!.forward();
    _videoController?.play();
    setState(() {});
  }

  // Dispose of the animation controller when the widget is disposed
  @override
  void dispose() {
    _animationController?.dispose();
    _timer?.cancel();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Column(
          children: [
            /// Story indicator which plays with timer, progress and total story Items
            /// check out widget in widgets dir.
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: widget.enableOnHoldHide == false
                          ? 1
                          : !_isPaused
                              ? 1
                              : 0,
                      child: StoryIndicator(
                        storyItemsLen: widget.storyItems.length,
                        currentItemIndex: currentItemIndex,
                        // Add this
                        progress: _progress,
                        indicatorColor: widget.indicatorColor,
                        indicatorHeight: widget.indicatorHeight,
                        indicatorValueColor: widget.indicatorValueColor,
                        indicatorPadding: widget.indicatorPadding,
                      ),
                    ),
                  ),
                  widget.headerRightActionWidget ?? const SizedBox.shrink()
                ],
              ),
            ),

            /// All story items mapped in the Stack widget
            Expanded(
              child: Stack(
                children: List.generate(
                  widget.storyItems.length,
                  (index) {
                    var story = widget.storyItems[index];
                    return Visibility(
                      visible: currentItemIndex == index,
                      maintainState: true,
                      child: _storyItem(story),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Creates a single story item widget
  _storyItem(StoryItem story) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.contentBorderRadius),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Visibility(
            visible: currentItemIndex == widget.storyItems.indexOf(story) &&
                story.type == StoryItemType.video &&
                (_videoController == null ||
                    !_videoController!.value.isInitialized) &&
                _isVideoLoading,
            child: Container(
              color: Colors.grey[600],
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              ),
            ),
          ),

          _switchStoryItemIsVideoOrImage(
            story,
            controller: _videoController, // Pass the controller
          ),

          // Next story area
          Align(
            alignment: Alignment.centerRight,
            heightFactor: 1,
            child: GestureDetector(
              onTapDown: (details) {
                _tapDownTime = DateTime.now();
                _timer = Timer(const Duration(milliseconds: 200), () {
                  _timer = null;
                  if (_tapDownTime != null && _isVideoLoading == false) {
                    final elapsedTime = DateTime.now()
                        .difference(_tapDownTime!)
                        .inMilliseconds;
                    if (elapsedTime >= 200) {
                      setState(() => _isPaused = true);
                      _pauseTimer();
                    } else {
                      /// Do nothing if the onTapDown is tapped less than 200 milliseconds
                    }
                  }
                });
              },
              onTapCancel: () {
                _resumeTimer();
                setState(() => _isPaused = false);
              },
              onTapUp: (details) {
                if (_tapDownTime != null) {
                  final elapsedTime = DateTime.now()
                      .difference(_tapDownTime!)
                      .inMilliseconds;
                  if (elapsedTime > 200) {
                    _resumeTimer();
                    setState(() => _isPaused = false);
                  } else {
                    _onTapNext();
                  }
                  _tapDownTime = null;
                }
              },
            ),
          ),

          // Previous story area
          Align(
            alignment: Alignment.centerLeft,
            heightFactor: 1,
            child: SizedBox(
              width: 70,
              child: GestureDetector(
                onTapDown: (details) {
                  _tapDownTime = DateTime.now();
                  _timer = Timer(const Duration(milliseconds: 200), () {
                    _timer = null;
                    if (_tapDownTime != null && _isVideoLoading == false) {
                      final elapsedTime = DateTime.now()
                          .difference(_tapDownTime!)
                          .inMilliseconds;
                      if (elapsedTime >= 200) {
                        setState(() => _isPaused = true);
                        _pauseTimer();
                      } else {
                        /// Do nothing if the onTapDown is tapped less than 200 milliseconds
                      }
                    }
                  });
                },
                onTapCancel: () {
                  _resumeTimer();
                  setState(() => _isPaused = false);
                },
                onTapUp: (details) {
                  if (_tapDownTime != null) {
                    final elapsedTime = DateTime.now()
                        .difference(_tapDownTime!)
                        .inMilliseconds;
                    if (elapsedTime > 200) {
                      _resumeTimer();
                      setState(() => _isPaused = false);
                    } else {
                      _onTapPrevious(); // return to previous story
                    }
                    _tapDownTime = null;
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _switchStoryItemIsVideoOrImage(
    StoryItem item, {
    VideoPlayerController? controller,
  }) {
    switch (item.type) {
      case StoryItemType.image:
        return item.fileExists
            ? StoryImage.file(item.filePath!)
            : StoryImage.url(item.url!);
      case StoryItemType.video:
        return item.fileExists
            ? StoryVideo.file(item.filePath!, controller)
            : StoryVideo.url(item.url!, controller);
      case StoryItemType.lottie:
        return item.fileExists
            ? StoryLottie.file(item.filePath!)
            : StoryLottie.url(item.url!);
    }
  }
}
