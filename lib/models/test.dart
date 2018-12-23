import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/post.dart';
import 'package:test_flutter_bankyo/ui/listPosts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';


class Test extends StatefulWidget {


  @override
  _Tests createState() => _Tests();
}

class _Tests extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Color.fromRGBO(0, 0, 0, 0.0),
      body:new Container(
        color: Colors.yellowAccent,
        child: new Row(
          children: [
            new Icon(
              Icons.access_time,
              size: 50.0,
            ),
            new Icon(
              Icons.pie_chart,
              size: 100.0,
            ),
            new Icon(
              Icons.email,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}


