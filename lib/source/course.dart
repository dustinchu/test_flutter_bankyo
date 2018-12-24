import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/screen/courseScreen.dart';
import 'package:test_flutter_bankyo/source/bankyo_api.dart';
import 'package:test_flutter_bankyo/screen/topAppBar.dart';

class Course extends StatelessWidget {
  final homeSelectId;


  Course(this.homeSelectId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: topAppBar(), body: CourseScreen(bankyoResource,homeSelectId));
  }
}
