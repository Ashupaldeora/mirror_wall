import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/web_provider.dart';

class SearchEngineDialog extends StatelessWidget {
  const SearchEngineDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final providerFalse = Provider.of<WebProvider>(context, listen: false);
    final providerTrue = Provider.of<WebProvider>(context, listen: true);
    return AlertDialog(
      title: Text("Choose Search Engine"),
      content: Container(
        height: 240,
        width: 400,
        child: Column(
          children: [
            ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) => RadioListTile(
                title: Text(providerTrue.searchEngineNames[index]),
                value: providerTrue.searchEngineNames[index],
                groupValue: providerTrue.groupValue,
                onChanged: (value) {
                  providerFalse.updateSearchEngineGroupValue(value!);
                  Navigator.pop(context);
                  providerFalse.updateSearchEngine(value!);

                  print(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
