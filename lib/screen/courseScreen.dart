import 'dart:convert';
import 'package:test_flutter_bankyo/screen/makeBotton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/coursePost.dart';
import 'package:test_flutter_bankyo/models/courseListview.dart';
import 'package:test_flutter_bankyo/models/test.dart';
import 'package:test_flutter_bankyo/utf/bankyoApi.dart';
import 'package:http/http.dart' as http;

class CourseScreen extends StatefulWidget {
  CourseScreen(this.bankyo, this.homeSelectId);

  final homeSelectId;
  final Bankyo bankyo;

  @override
  _CourseScreenState createState() =>
      new _CourseScreenState(bankyo, homeSelectId);
}

class _CourseScreenState extends State<CourseScreen> {
  _CourseScreenState(this.bankyo, this.homeSelectId);

  final homeSelectId;
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
          body: FutureBuilder<List<CoursePosts>>(
            future: fetchPosts(http.Client(), bankyo, homeSelectId),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? CourseListViewPosts(posts: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
          bottomNavigationBar: makeBotton(),
        ),
      ),
    );
  }
}

Future<List<CoursePosts>> fetchPosts(
    http.Client client, Bankyo bankyoUrl, homeSelectId) async {
  final response =
      await client.get(bankyoUrl.courseListViewUrl + '${homeSelectId}');

  return compute(parsePosts, response.body);
}

List<CoursePosts> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<CoursePosts>((json) => CoursePosts.fromJson(json)).toList();
}
