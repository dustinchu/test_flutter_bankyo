import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/screen/courseScreen.dart';
import 'package:test_flutter_bankyo/utf/bankyoApi.dart';
import 'package:test_flutter_bankyo/appBar/courseAppBar.dart';
import 'package:test_flutter_bankyo/posts/coursePost.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:test_flutter_bankyo/utf/course.dart';

class Course extends StatelessWidget {
  final homeSelectId;
  final itemName;

  Course(this.homeSelectId, this.itemName);

  @override
  Widget build(BuildContext context) {
    final Future<List<CoursePosts>> posts =
        fetchPosts(http.Client(), bankyoResource, homeSelectId);
    return Scaffold(
        appBar: courseAppBar(context, itemName),
        body: CourseScreen(posts));
  }
}

//撈取課程資料 回傳一個json
Future<List<CoursePosts>> fetchPosts(
    http.Client client, Bankyo bankyoUrl, homeSelectId) async {
  final response =
      await client.get(bankyoUrl.courseListViewUrl + '${homeSelectId}');
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
