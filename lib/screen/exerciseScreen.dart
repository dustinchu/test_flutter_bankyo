import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/appBar/HomeAppBar.dart';
import 'package:test_flutter_bankyo/posts/exercisePost.dart';
import 'package:test_flutter_bankyo/models/exerciseListView.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter_bankyo/posts/urlPost.dart';
class ExerciseScreen extends StatefulWidget {

  @override
  _ExerciseScreenState createState() => new _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {


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
          body: FutureBuilder<List<ExercisePost>>(
            future: fetchPosts(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? ExerciseListViewPosts(posts: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        )));
  }
}

Future<List<ExercisePost>> fetchPosts(http.Client client) async {
  final response = await client.get(url[0].exercise);

  return compute(parsePosts, response.body);
}

List<ExercisePost> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ExercisePost>((json) => ExercisePost.fromJson(json)).toList();
}
