import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: providerTrue.bookmarks.length,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.only(right: 0, left: 20),
              onTap: () {
                Navigator.pop(context);
                providerFalse.webViewController!.loadUrl(
                    urlRequest: URLRequest(
                        url: WebUri(providerFalse.bookmarks[index].bookMark
                            .toString())));
              },
              title: Text(
                providerTrue.bookmarks[index].title.toString(),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                providerTrue.bookmarks[index].bookMark.toString(),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {
                  providerFalse.removeBookmark(index);
                },
                icon: Icon(Icons.cancel_outlined),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration:
            BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Dismiss"),
        ),
      ),
    );
  }
}
