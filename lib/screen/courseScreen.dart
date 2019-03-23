import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/coursePost.dart';
import 'package:test_flutter_bankyo/models/courseListview.dart';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:test_flutter_bankyo/appBar/courseAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:test_flutter_bankyo/utf/course.dart';
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
          backgroundColor: Color.fromRGBO(29, 29, 38, 0.2),
          body: FutureBuilder<List<CoursePosts>>(
            future: posts,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? CourseListViewPosts(posts: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
//          bottomNavigationBar: MakeBottonScreenState(),
        ),
      ),
    );
  }
}




class Course extends StatelessWidget {
  final homeSelectId;
  final itemName;

  Course(this.homeSelectId, this.itemName);

  @override
  Widget build(BuildContext context) {
    final Future<List<CoursePosts>> posts =
    fetchPosts(http.Client(), homeSelectId);
    return Scaffold(
        appBar: courseAppBar(context, itemName),
        body: CourseScreen(posts));
  }
}

//撈取課程資料 回傳一個json
Future<List<CoursePosts>> fetchPosts(
    http.Client client, homeSelectId) async {
  final response =
  await client.get(url[0].courseListViewUrl + '${homeSelectId}');
  //save Json Length  儲存到static
  ListLength.length = parsePosts(response.body).length;
  return compute(parsePosts, response.body);
}

List<CoursePosts> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //將list先存起來 讓練習dialog使用
  ListLength.coursePostsList =
      parsed.map<CoursePosts>((json) => CoursePosts.fromJson(json)).toList();
  return parsed.map<CoursePosts>((json) => CoursePosts.fromJson(json)).toList();
}
