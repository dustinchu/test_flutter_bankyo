import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/ui/topAppBar.dart';
import 'package:test_flutter_bankyo/post.dart';
import 'package:test_flutter_bankyo/ui/listPosts.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                backgroundColor: Color.fromRGBO(29, 29,38, 0.1),
                appBar: topAppBar(),
                body:FutureBuilder<List<Post>>(
                  future: fetchPosts(http.Client()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);

                    return snapshot.hasData
                        ? ListViewPosts(posts: snapshot.data)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              )




            )
        );
  }

}
Future<List<Post>> fetchPosts(http.Client client) async {
  final response = await client.get('http://192.168.1.173:5000/stores'
  );

  return compute(parsePosts, response.body);
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}