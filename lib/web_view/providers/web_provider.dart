import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/bookmarks/models/bookmark_data.dart';

class WebProvider extends ChangeNotifier {
  InAppWebViewController? webViewController;
  TextEditingController textEditingController = TextEditingController();
  double progress = 0;
  String searchedText = '';
  String? title;
  List<BookmarkModel> bookmarks = [];
  List searchEngineNames = ['Google', 'Bing', 'Duck Duck Go', 'Yahoo'];
  String selectedSearchEngine = 'Google';
  String? searchedUrl;
  bool isButtonEnabled = true;

  String groupValue = 'Google';
  PullToRefreshController? pullToRefreshController;
  Future<void> updateSearchedUrl(WebUri? url, Future<String?> title) async {
    searchedUrl = url.toString();
    this.title = await title;
    checkIfShouldGoBack();
    notifyListeners();
  }

  void addBookmark() {
    bookmarks.add(BookmarkModel(bookMark: searchedUrl, title: title));
    notifyListeners();
  }

  void updateSearchEngine(String value) {
    selectedSearchEngine = value;
    if (selectedSearchEngine == 'Google') {
      webViewController!.loadUrl(
          urlRequest: URLRequest(url: WebUri("https://www.google.com/")));
    } else if (selectedSearchEngine == 'Yahoo') {
      webViewController!.loadUrl(
          urlRequest: URLRequest(url: WebUri("https://in.search.yahoo.com/")));
    } else if (selectedSearchEngine == 'Bing') {
      webViewController!.loadUrl(
          urlRequest: URLRequest(url: WebUri("https://www.bing.com/")));
    } else if (selectedSearchEngine == 'Duck Duck Go') {
      webViewController!.loadUrl(
          urlRequest: URLRequest(url: WebUri("https://duckduckgo.com/")));
    }
    notifyListeners();
  }

  void updateSearchEngineGroupValue(String value) {
    groupValue = value;
    notifyListeners();
  }

  void removeBookmark(int index) {
    bookmarks.removeAt(index);
    notifyListeners();
  }

  void searchAtSelectedSearchEngine() {
    if (selectedSearchEngine == 'Google') {
      webViewController!.loadUrl(
          urlRequest: URLRequest(
              url: WebUri(
                  "https://www.google.com/search?q=${searchedText}&rlz=1C1ONGR_enIN1095IN1095&oq=hi&gs_lcrp=EgZjaHJvbWUqDggAEEUYJxg7GIAEGIoFMg4IABBFGCcYOxiABBiKBTIGCAEQRRg7Mg0IAhAAGIMBGLEDGIAEMg0IAxAuGIMBGLEDGIAEMhAIBBAAGIMBGLEDGIAEGIoFMg0IBRAAGIMBGLEDGIAEMhYIBhAuGIMBGMcBGLEDGNEDGIAEGIoFMgcIBxAAGIAEMgcICBAAGIAEMhAICRAuGIMBGLEDGIAEGIoF0gEJMTIzNmowajE1qAIJsAIB&sourceid=chrome&ie=UTF-8")));
    } else if (selectedSearchEngine == 'Yahoo') {
      webViewController!.loadUrl(
          urlRequest: URLRequest(
              url: WebUri(
                  "https://in.search.yahoo.com/search;_ylt=AwrPoYNX0lFm3wcpV0y7HAx.;_ylc=X1MDMjExNDcyMzAwMwRfcgMyBGZyA2NybWFzBGZyMgNzYi10b3AEZ3ByaWQDZlRUNGtwSXdUSjZmZURhT2FPdnRXQQRuX3JzbHQDMARuX3N1Z2cDMTAEb3JpZ2luA2luLnNlYXJjaC55YWhvby5jb20EcG9zAzAEcHFzdHIDBHBxc3RybAMwBHFzdHJsAzExBHF1ZXJ5A2ZsdXR0ZXIlMjBkZXYEdF9zdG1wAzE3MTY2MzgzMDE-?p=${searchedText}&fr2=sb-top&fr=crmas&vm=r")));
    } else if (selectedSearchEngine == 'Bing') {
      webViewController!.loadUrl(
          urlRequest: URLRequest(
              url: WebUri(
                  "https://www.bing.com/search?q=${searchedText}&qs=n&form=QBRE&sp=-1&lq=0&pq=flutter+dev&sc=19-11&sk=&cvid=B4B782306ED143AE9326650EBDDC17DC&ghsh=0&ghacc=0&ghpl=")));
    } else if (selectedSearchEngine == 'Duck Duck Go') {
      webViewController!.loadUrl(
          urlRequest: URLRequest(
              url: WebUri("https://duckduckgo.com/?q=${searchedText}&ia=web")));
    }
  }

  WebProvider() {
    pullToRefreshController = PullToRefreshController(
      onRefresh: () {
        webViewController!.reload();
      },
    );
  }

  void checkIfShouldGoBack() {
    if (searchedUrl == 'https://www.google.com/' ||
        searchedUrl == 'https://in.search.yahoo.com/' ||
        searchedUrl == 'https://www.bing.com/' ||
        searchedUrl == 'https://duckduckgo.com/') {
      print(searchedUrl);
      isButtonEnabled = false;

      notifyListeners();
    } else {
      isButtonEnabled = true;

      notifyListeners();
    }
  }

  Future<bool> timePass() async {
    if (isButtonEnabled) {
      await webViewController!.goBack();
      return true;
    }

    notifyListeners();
    return false;
  }

  void onProgressChanged(int progress) {
    this.progress = progress / 100;
    notifyListeners();
  }

  void updateSearchedText(String text) {
    searchedText = text;
    notifyListeners();
  }
}
