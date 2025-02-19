import 'package:common_module/base/base_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:zinc/core/webview/bloc/webview_states.dart';

class WebViewBloc extends BaseCubit<WebViewState> {
  Map<String, dynamic>? cookies;
  final String url;
  final String? successUrl;
  final String? windowId;
  late String domain;
  final cookieManager = CookieManager.instance();

  WebViewBloc._(this.url, {this.cookies, this.successUrl, this.windowId})
      : super(WebViewLoading());

  factory WebViewBloc.create(String url,
      {Map<String, dynamic>? cookies, String? successUrl, String? windowId}) {
    return WebViewBloc._(url, cookies: cookies, successUrl: successUrl, windowId: windowId);
  }

  void loadPage() async {
    await cookieManager.getCookies(url: WebUri(url)).then((cookies) {
      cookies.forEach((cookie) async {
        await cookieManager.setCookie(
          url: WebUri(url),
          name: cookie.name,
          value: cookie.value,
          domain: cookie.domain,
          path: cookie.path ?? "",
          isSecure: cookie.isSecure,
          isHttpOnly: cookie.isHttpOnly,
        );
      });
    });
    emitState(WebViewLoaded(url));
  }

  Future<void> transferCookies(String fromUrl, String toUrl) async {
    // Step 1: Get cookies from the first URL
    Uri uriFrom = Uri.parse(fromUrl);
    List<Cookie> cookies = await cookieManager.getCookies(url: WebUri(fromUrl));

    // Step 2: Set these cookies to the new URL
    Uri uriTo = Uri.parse(toUrl);
    await Future.wait(cookies
        .map((c) => cookieManager.setCookie(
              url: WebUri(toUrl),
              name: c.name,
              value: c.value,
              domain: uriTo.host,
              path: c.path ?? "",
              isHttpOnly: c.isHttpOnly,
              isSecure: c.isSecure,
              expiresDate: c.expiresDate,
              sameSite: c.sameSite,
            ))
        .toList());
  }

  @override
  void handleError(err) {
    super.handleError(err);
  }
}
