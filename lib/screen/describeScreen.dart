import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:test_flutter_bankyo/appBar/homeAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:test_flutter_bankyo/posts/describePost.dart';
import 'package:test_flutter_bankyo/models/describeListView.dart';


class DescribeScreen extends StatefulWidget {

  @override
  _DescribeScreenState createState() => new _DescribeScreenState();
}

class _DescribeScreenState extends State<DescribeScreen> {


  @override
  build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                const Color.fromRGBO(33, 208, 253, 1.0),
                const Color.fromRGBO(238, 77, 185, 1.0),
              ],
              stops: [0.0, 1.0],
            )),
        child: new Container(
            child: new Scaffold(
              //漸層背景在上一層
              backgroundColor: Color.fromRGBO(29, 29, 38, 0.2),
              appBar: topAppBar(),
              body: FutureBuilder<List<DescribePosts>>(
                future: fetchPosts(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? DescribeListViewPosts(posts: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            )));
  }
}

Future<List<DescribePosts>> fetchPosts(http.Client client) async {
  final response = await client.get(url[0].describeListViewUrl);

  return compute(parsePosts, response.body);
}

List<DescribePosts> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<DescribePosts>((json) => DescribePosts.fromJson(json)).toList();
}
