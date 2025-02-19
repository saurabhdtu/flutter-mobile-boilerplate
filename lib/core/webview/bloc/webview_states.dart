abstract class WebViewState{}

class WebViewLoading extends WebViewState{}

class WebViewLoaded extends WebViewState{
  final String url;

  WebViewLoaded(this.url);
}