import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall/bookmarks/view/bookmarks.dart';
import 'package:mirror_wall/web_view/providers/web_provider.dart';
import 'package:mirror_wall/web_view/view/web_view_screen.dart';
import 'package:provider/provider.dart';

import 'history/view/history_screen.dart';

void main() {
  runApp(MirrorWall());
}

class MirrorWall extends StatelessWidget {
  const MirrorWall({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WebProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home': (context) => WebViewScreen(),
          '/bookmark': (context) => BookMarks(),
          '/history': (context) => HistoryScreen(),
        },
      ),
    );
  }
}
