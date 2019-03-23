import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/newsTitlePost.dart';
import 'package:test_flutter_bankyo/models/newsTitleListView.dart';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:http/http.dart' as http;
class NewsTitleScreen extends StatefulWidget {

  @override
  _NewsTitleScreenState createState() => new _NewsTitleScreenState();
}

class _NewsTitleScreenState extends State<NewsTitleScreen> {


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
//              appBar: topAppBar(),
              body: FutureBuilder<List<NewsTitlePosts>>(
                future: fetchPosts(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? NewsTitleListViewPosts(posts: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            )));
  }
}

Future<List<NewsTitlePosts>> fetchPosts(http.Client client) async {
  final response = await client.get(url[0].newsTtile);

  return compute(parsePosts, response.body);
}

List<NewsTitlePosts> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<NewsTitlePosts>((json) => NewsTitlePosts.fromJson(json)).toList();
}
