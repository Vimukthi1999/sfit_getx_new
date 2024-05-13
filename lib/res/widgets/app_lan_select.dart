// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';


Future<void> appSelectLanguage(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        // <-- SEE HERE
        title:  const Text("select option"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () async {
              Navigator.of(context).pop();
             
            },
            child: const Text('English'),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: const Text('සිංහල'),
          ),
          SimpleDialogOption(
            onPressed: () async {
              
              Navigator.of(context).pop();
            },
            child: const Text('தமிழ்'),
          ),
        ],
      );
    },
  );
}
