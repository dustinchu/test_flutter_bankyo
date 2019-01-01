import 'dart:convert';
import 'package:test_flutter_bankyo/screen/makeBotton.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/coursePost.dart';
import 'package:test_flutter_bankyo/models/courseListview.dart';

class CourseScreen extends StatefulWidget {
  CourseScreen(this.posts);

  final Future<List<CoursePosts>> posts;

  @override
  _CourseScreenState createState() => new _CourseScreenState(posts);
}

class _CourseScreenState extends State<CourseScreen> {
  _CourseScreenState(this.posts);

  final Future<List<CoursePosts>> posts;

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
            future: posts,
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
