import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/utils/zinc_widget_utils.dart';
import 'package:flutter/material.dart';

enum ZincSnackbarType {
  neutral,
  negative,
  positive,
  accent,
  warning,
}

///Usage:
//ZincSystemBanner.showSystemBanner(
//   context,
//   text: 'This is a system banner',
//   leftIcon: const Icon(Icons.info),
//   rightIcon: const Icon(Icons.close),
//   rightIconAction: () {
//     print(
//         'Snackbar dismissed and additional action executed.');
//   },
//   autoDismissible: true,
//   snackbarType: ZincSnackbarType.neutral,
//   durationInMs: 100,
// );

class ZincSystemBanner extends StatefulWidget {
  final String text;
  final Color? backgroundColor;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? rightIconAction;
  final VoidCallback? onDismiss;
  final bool autoDismissible;
  final int durationInMs; //default is 3000ms = 3s
  final ZincSnackbarType? snackbarType;
  final TextStyle? titleStyle;

  const ZincSystemBanner({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.leftIcon,
    this.rightIcon,
    this.rightIconAction,
    this.onDismiss,
    required this.autoDismissible,
    this.durationInMs = 3000,
    this.snackbarType = ZincSnackbarType.neutral,
    this.titleStyle,
  }) : super(key: key);

  @override
  _ZincSystemBannerState createState() => _ZincSystemBannerState();

  static void showSystemBanner({
    required BuildContext context,
    required String text,
    Color? backgroundColor,
    final Widget? leftIcon,
    final Widget? rightIcon,
    final VoidCallback? rightIconAction,
    bool autoDismissible = true,
    int durationInMs = 3000,
    ZincSnackbarType snackbarType = ZincSnackbarType.neutral,
    TextStyle? titleStyle,
  }) {
    final overlay = Overlay.of(context);
    final snackbarKey = GlobalKey<_ZincSystemBannerState>();

    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => ZincSystemBanner(
        key: snackbarKey,
        text: text,
        backgroundColor: backgroundColor,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
        rightIconAction: rightIconAction,
        onDismiss: () {
          if (overlayEntry != null) {
            overlayEntry.remove();
          }
        },
        autoDismissible: autoDismissible,
        durationInMs: durationInMs,
        snackbarType: snackbarType,
        titleStyle: titleStyle,
      ),
    );

    overlay.insert(overlayEntry);

    if (autoDismissible) {
      Future.delayed(Duration(milliseconds: durationInMs), () {
        if (snackbarKey.currentState != null &&
            snackbarKey.currentState!.mounted) {
          snackbarKey.currentState!.dismiss();
        }
      });
    }
  }
}

class _ZincSystemBannerState extends State<ZincSystemBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.2), // Start position off the screen
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void dismiss() {
    _animationController.reverse().then((_) {
      widget.onDismiss!();
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    Color backgroundColor = widget.backgroundColor ??
        getSnackBarBackgroundColor(
            widget.snackbarType! ?? ZincSnackbarType.neutral);

    TextStyle titleTextStyle =
        widget.titleStyle ?? const ZincTextStyle.normalSemiBold();

    if (widget.backgroundColor == null) {
      switch (widget.snackbarType) {
        case ZincSnackbarType.accent:
          titleTextStyle =
              titleTextStyle.copyWith(color: GreyscaleText().title);
          break;
        case ZincSnackbarType.negative:
          titleTextStyle =
              titleTextStyle.copyWith(color: GreyscaleText().white);
          break;
        case ZincSnackbarType.positive:
          titleTextStyle =
              titleTextStyle.copyWith(color: GreyscaleText().white);
          break;
        case ZincSnackbarType.warning:
          titleTextStyle =
              titleTextStyle.copyWith(color: GreyscaleText().title);
          break;
        case ZincSnackbarType.neutral:
        default:
          titleTextStyle = titleTextStyle.copyWith(
            color: GreyscaleText().white,
          );
          break;
      }
    }

    return Positioned(
      top: 0, // Adjust position to be behind the status bar
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          elevation: 0,
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.only(
              top: statusBarHeight + 8,
              left: 16.0,
              right: 16.0,
              bottom: 8,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.leftIcon != null) widget.leftIcon!,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 16,
                      ),
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.start,
                        style: widget.titleStyle ?? titleTextStyle,
                      ),
                    ),
                  ),
                  if (widget.rightIcon != null)
                    InkWell(
                      child: widget.rightIcon,
                      onTap: () {
                        if (widget.rightIconAction != null) {
                          widget.rightIconAction!();
                        }
                        dismiss();
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
