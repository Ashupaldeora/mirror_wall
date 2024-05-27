import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../web_view/providers/web_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
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
                "  History",
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
          TextButton(
              onPressed: () {
                providerFalse.clearWholeHistory();
              },
              child: Text("clear browsing data")),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              // reverse: true,
              itemCount: providerTrue.history.length,
              itemBuilder: (context, index) => ListTile(
                contentPadding: EdgeInsets.only(
                  right: 0,
                  left: 20,
                ),
                leading: Image.asset(
                  providerTrue
                      .history[providerTrue.history.length - (index + 1)].image
                      .toString(),
                  height: 20,
                ),
                onTap: () {
                  Navigator.pop(context);

                  providerFalse.webViewController!.loadUrl(
                      urlRequest: URLRequest(
                          url: WebUri(providerFalse
                              .history[
                                  providerTrue.history.length - (index + 1)]
                              .history
                              .toString())));
                },
                title: Text(
                  providerTrue
                      .history[providerTrue.history.length - (index + 1)].title
                      .toString(),
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  providerTrue
                      .history[providerTrue.history.length - (index + 1)]
                      .history
                      .toString(),
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () {
                    providerFalse.removeHistory(
                        providerTrue.history.length - (index + 1));
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
