import 'package:flutter/material.dart';

import 'package:mirror_wall/web_view/view/components/engine_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../../providers/web_provider.dart';

AppBar WebViewAppBar(
    WebProvider providerTrue, WebProvider providerFalse, BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xff121212),
    toolbarHeight: 90,
    leading: IconButton(
      onPressed: () {
        providerFalse.goHome();
      },
      icon: Icon(
        Icons.home_outlined,
        color: Colors.white,
        size: 30,
      ),
    ),
    leadingWidth: 30,
    title: SizedBox(
      height: 41,
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: providerTrue.textEditingController,
        onSubmitted: (value) {
          providerFalse.updateSearchedText(value);
          providerFalse.searchAtSelectedSearchEngine();
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff343039),
          contentPadding: EdgeInsets.only(top: 5, left: 15),
          hintText: "Search Here",
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5),
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
          icon: Icon(
            Icons.star_border_purple500_outlined,
            color: Colors.white,
          )),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.file_download_outlined,
            color: Colors.white,
          )),
      PopupMenuButton(
        iconColor: Colors.white,
        color: Color(0xff332940),
        shadowColor: Colors.black,
        surfaceTintColor: Color(0xff302836),
        elevation: 20,
        onSelected: (value) {
          if (value == "Bookmarks") {
            Navigator.of(context).pushNamed('/bookmark');
          } else if (value == "Search Engine") {
            showDialog(
              context: context,
              builder: (context) => const SearchEngineDialog(),
            );
          } else {
            Navigator.of(context).pushNamed('/history');
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        itemBuilder: (context) => [
          PopupMenuItem<String>(
            value: 'Bookmarks',
            child: ListTile(
              leading: Icon(
                Icons.star_border,
                color: Colors.grey,
              ),
              title: Text('Bookmarks',
                  style: TextStyle(color: Colors.grey.shade300)),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Search Engine',
            child: ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              title: Text('Search Engine',
                  style: TextStyle(color: Colors.grey.shade300)),
            ),
          ),
          PopupMenuItem<String>(
            value: 'History',
            child: ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.grey,
              ),
              title: Text(
                'History',
                style: TextStyle(color: Colors.grey.shade300),
              ),
            ),
          ),
        ],
      )
    ],
  );
}
