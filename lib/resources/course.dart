import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/screen/courseScreen.dart';
import 'package:test_flutter_bankyo/utf/bankyoApi.dart';
import 'package:test_flutter_bankyo/appBar/courseAppBar.dart';

class Course extends StatelessWidget {
  final homeSelectId;

  Course(this.homeSelectId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: courseAppBar(context,"title"),
        body: CourseScreen(bankyoResource, homeSelectId));
  }
}
