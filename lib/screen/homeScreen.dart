import 'dart:convert';
import 'package:test_flutter_bankyo/screen/makeBotton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/appBar/HomeAppBar.dart';
import 'package:test_flutter_bankyo/posts/homePost.dart';
import 'package:test_flutter_bankyo/models/homeListView.dart';
import 'package:test_flutter_bankyo/utf/bankyoApi.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen(this.bankyo);

  final Bankyo bankyo;

  @override
  _HomeScreenState createState() => new _HomeScreenState(bankyo);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState(this.bankyo);

  final Bankyo bankyo;

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
          backgroundColor: Color.fromRGBO(29, 29, 38, 0.1),
          appBar: topAppBar(),
          body: FutureBuilder<List<HomePosts>>(
            future: fetchPosts(http.Client(), bankyo),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? HomeListViewPosts(posts: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
          bottomNavigationBar: makeBotton(),
        )));
  }
}

Future<List<HomePosts>> fetchPosts(http.Client client, Bankyo bankyoUrl) async {
  final response = await client.get(bankyoUrl.homeListViewUrl);

  return compute(parsePosts, response.body);
}

List<HomePosts> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<HomePosts>((json) => HomePosts.fromJson(json)).toList();
}
