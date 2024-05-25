import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/web_view/view/components/engine_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../../providers/web_provider.dart';

AppBar WebViewAppBar(
    WebProvider providerTrue, WebProvider providerFalse, BuildContext context) {
  return AppBar(
    toolbarHeight: 90,
    title: SizedBox(
      height: 41,
      child: TextField(
        controller: providerTrue.textEditingController,
        onSubmitted: (value) {
          providerFalse.updateSearchedText(value);
          providerFalse.searchAtSelectedSearchEngine();
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: EdgeInsets.only(top: 5, left: 15),
          hintText: "Search Here",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              )),
        ),
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            providerFalse.addBookmark();
          },
          icon: Icon(Icons.star_border_purple500_outlined)),
      IconButton(onPressed: () {}, icon: Icon(Icons.file_download_outlined)),
      PopupMenuButton(
        color: Colors.white,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        elevation: 20,
        onSelected: (value) {
          if (value == "Bookmarks") {
            Navigator.of(context).pushNamed('/bookmark');
          } else {
            showDialog(
              context: context,
              builder: (context) => const SearchEngineDialog(),
            );
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        itemBuilder: (context) => [
          const PopupMenuItem<String>(
            value: 'Bookmarks',
            child: ListTile(
              leading: Icon(Icons.star_border),
              title: Text('Bookmarks'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'Search Engine',
            child: ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Engine'),
            ),
          ),
        ],
      )
    ],
  );
}
