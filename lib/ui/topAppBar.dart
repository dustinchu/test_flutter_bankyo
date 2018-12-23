import 'package:flutter/material.dart';





 Widget topAppBar() {
  return AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(0, 185, 255, 1.0),
    title: Text("title"),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      )
    ],
  );
}
