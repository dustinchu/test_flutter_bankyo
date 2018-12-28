
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/dialog/bankyoCard.dart';

  Widget courseAppBar(BuildContext context , String text) {
    return AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(0, 185, 255, 1.0),
      title: Text("title"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.chat),
          onPressed: () {
          ShowDialog(context);
          },
        )
      ],
    );
  }

