import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utility_module/logger/logger.dart';
import 'package:zinc/app/constant.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/core/webview/bloc/webview_bloc.dart';
import 'package:zinc/core/webview/bloc/webview_states.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';

class ZincWebView extends StatefulWidget {
  final String? title;
  final bool? showAppBar;

  const ZincWebView({this.title = "", this.showAppBar = true, super.key});

  @override
  State<StatefulWidget> createState() => _ZincWebViewState();
}

class _ZincWebViewState extends State<ZincWebView> {
  late WebViewBloc _bloc;
  InAppWebViewController? _webViewController;
  int progress = 0;
  InAppWebViewSettings settings = InAppWebViewSettings(
      javaScriptCanOpenWindowsAutomatically: true,
      supportMultipleWindows: true,
      javaScriptEnabled: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return BlocBuilder<WebViewBloc, WebViewState>(builder: (context, state) {
      if (state is WebViewLoaded) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (await _webViewController?.canGoBack() == true) {
              _webViewController?.goBack();
            } else if (result == true) {
              context.pop(true);
            }
          },
          child: ZincScaffold.scaffold(
              context,
              "webview_",
              SizedBox(
                width: size.width,
                height: size.height -
                    padding.top -
                    padding.bottom -
                    (widget.showAppBar == true ? 50.0 : 0),
                child: Stack(
                  children: [
                    InAppWebView(
                        initialUrlRequest: URLRequest(url: WebUri(state.url)),
                        onLoadStart: (controller, url) {
                          _webViewController = controller;
                        },
                        initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                            javaScriptCanOpenWindowsAutomatically: true,
                            mediaPlaybackRequiresUserGesture: false,
                          ),
                          ios: IOSInAppWebViewOptions(
                            allowsInlineMediaPlayback: true,
                          ),
                          android: AndroidInAppWebViewOptions(
                            supportMultipleWindows: true,
                          ),
                        ),
                        // initialSettings: settings,
                        onConsoleMessage: (InAppWebViewController controller,
                            ConsoleMessage message) {
                          print("=======> Console Message: ${message.message}");
                        },
                        onPermissionRequest: _onPermissionRequest,
                        onCreateWindow: (controller, createWindowAction) async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return WindowPopup(
                                  createWindowAction: createWindowAction);
                            },
                          );
                          return true;

                        },
                        shouldOverrideUrlLoading: _handleUrlOverloading,
                        onProgressChanged: _onProgressChangedForThePage),
                    if (progress > 0 && progress < 100)
                      SizedBox(
                          height: 5.0,
                          child: LinearProgressIndicator(
                            color: SuccessSurface().darker,
                            backgroundColor: GreyscaleSurface().lighter,
                          ))
                  ],
                ),
              ),
              showAppBar: widget.showAppBar ?? true,
              showHelp:
                  !state.url.contains(ApplicationBloc.appURLs.faqUrl ?? "")),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Future<NavigationActionPolicy> _handleUrlOverloading(
      InAppWebViewController controller, NavigationAction navigationAction) {
    if (_bloc.successUrl != null) {
      if (navigationAction.request.url
              ?.toString()
              .contains(_bloc.successUrl ?? "") ==
          true) {
        context.pop(navigationAction.request.url?.toString());
        return Future.value(NavigationActionPolicy.CANCEL);
      } else if (navigationAction.request.url?.toString().contains("error") ==
          true) {
        context.pop(Constant.pageResultError);
        return Future.value(NavigationActionPolicy.CANCEL);
      }
    }
    return Future.value(NavigationActionPolicy.ALLOW);
  }

  void _onProgressChangedForThePage(
      InAppWebViewController controller, int progress) {
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
    _bloc.loadPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<PermissionResponse?> _onPermissionRequest(
      InAppWebViewController controller, PermissionRequest request) async {
    if (request.resources.contains(PermissionResourceType.CAMERA) ||
        request.resources.contains(PermissionResourceType.MICROPHONE)) {
      // Automatically grant permissions if they have been already granted
      PermissionStatus cameraStatus = await Permission.camera.status;
      PermissionStatus microphoneStatus = await Permission.microphone.status;

      if (cameraStatus.isGranted && microphoneStatus.isGranted) {
        return PermissionResponse(
          resources: request.resources,
          action: PermissionResponseAction.GRANT,
        );
      } else {
        return PermissionResponse(
          resources: request.resources,
          action: PermissionResponseAction.DENY,
        );
      }
    }
    return PermissionResponse(
      resources: request.resources,
      action: PermissionResponseAction.GRANT,
    );
  }
}

class WindowPopup extends StatefulWidget {
  final CreateWindowAction createWindowAction;

  const WindowPopup({Key? key, required this.createWindowAction})
      : super(key: key);

  @override
  State<WindowPopup> createState() => _WindowPopupState();
}

class _WindowPopupState extends State<WindowPopup> {
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(mainAxisSize: MainAxisSize.max, children: [
                  Expanded(
                    child: Text(title,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ]),
                Expanded(
                  child: InAppWebView(
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    windowId: widget.createWindowAction.windowId,
                    onTitleChanged: (controller, title) {
                      setState(() {
                        this.title = title ?? '';
                      });
                    },
                    onCloseWindow: (controller) {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            height: 75,
          )
        ],
      ),
    );
  }
}
