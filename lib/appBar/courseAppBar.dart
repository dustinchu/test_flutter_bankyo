
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/dialog/bankyoCard.dart';

  Widget courseAppBar(BuildContext context , String titleName) {
    return AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(0, 185, 255, 1.0),
      title: Text(titleName),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
          ShowDialog(context);
//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => Exercise()));
          },
        )
      ],
    );
  }
