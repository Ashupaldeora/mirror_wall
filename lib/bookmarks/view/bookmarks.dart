import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/web_view/providers/web_provider.dart';
import 'package:provider/provider.dart';

class BookMarks extends StatelessWidget {
  const BookMarks({super.key});

  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<WebProvider>(context);
    final providerFalse = Provider.of<WebProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "  Bookmarks",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    "assets/images/close.png",
                    height: 15,
                    color: Colors.white,
                  ))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: providerTrue.bookmarks.length,
              itemBuilder: (context, index) => ListTile(
                contentPadding: EdgeInsets.only(right: 0, left: 20),
                leading: Image.asset(
                  "assets/images/world-wide-web.png",
                  height: 30,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);

                  providerFalse.webViewController!.loadUrl(
                      urlRequest: URLRequest(
                          url: WebUri(providerFalse
                              .bookmarks[
                                  providerTrue.bookmarks.length - (index + 1)]
                              .bookMark
                              .toString())));
                },
                title: Text(
                  providerTrue
                      .bookmarks[providerTrue.bookmarks.length - (index + 1)]
                      .title
                      .toString(),
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  providerTrue
                      .bookmarks[providerTrue.bookmarks.length - (index + 1)]
                      .bookMark
                      .toString(),
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () {
                    providerFalse.removeBookmark(
                        providerTrue.bookmarks.length - (index + 1));
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
