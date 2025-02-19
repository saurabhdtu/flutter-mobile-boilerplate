import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() async {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad(didLoadSuccessfully) {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }


  @override
  void onInitialLoadDidRedirect(WebUri? url) {
    print("Load redirect ${url.toString()}");
    super.onInitialLoadDidRedirect(url);
  }


}

class WebBrowserUtils {
  static WebBrowserUtils? _instance;

  WebBrowserUtils._();

  static WebBrowserUtils get instance => _instance ??= WebBrowserUtils._();

  Future<void> launchWebUrlInChromeSafariTab(String url) {
    final browser = MyChromeSafariBrowser();
    return browser.open(
        url: WebUri(url),
        settings: ChromeSafariBrowserSettings(
            shareState: CustomTabsShareState.SHARE_STATE_OFF,
            isSingleInstance: false,
            isTrustedWebActivity: true,
            enableUrlBarHiding: true,
            keepAliveEnabled: true,
            startAnimations: [
              AndroidResource.anim(
                  name: "slide_in_left", defPackage: "android"),
              AndroidResource.anim(
                  name: "slide_out_right", defPackage: "android")
            ],
            exitAnimations: [
              AndroidResource.anim(
                  name: "abc_slide_in_top",
                  defPackage:
                      "com.pichillilorenzo.flutter_inappwebviewexample"),
              AndroidResource.anim(
                  name: "abc_slide_out_top",
                  defPackage: "com.pichillilorenzo.flutter_inappwebviewexample")
            ],
            dismissButtonStyle: DismissButtonStyle.CLOSE,
            presentationStyle: ModalPresentationStyle.OVER_FULL_SCREEN));
  }
}
