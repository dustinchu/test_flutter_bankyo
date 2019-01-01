
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/dialog/bankyoCard.dart';
import 'package:test_flutter_bankyo/resources/exercise.dart';
import 'package:test_flutter_bankyo/posts/coursePost.dart';

  Widget courseAppBar(BuildContext context , String titleName) {
    return AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(0, 185, 255, 1.0),
      title: Text(titleName),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.chat),
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
