import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/bottomNavigtion/bottomCustomTab.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:test_flutter_bankyo/screen/welcomeScreen.dart';
import 'package:test_flutter_bankyo/bottomNavigtion/bottomCustomTab.dart';
//
var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Tabbed(),
};

void main() {
//  debugPaintSizeEnabled = true;
  runApp(
      new MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: _buildTheme(),
      //將url連線資料傳過去
//      home: Tabbed(),
      debugShowCheckedModeBanner: true,
    home: WelcomeScreen(),
      routes: routes,

    );
  }
}


ThemeData _buildTheme() {
  //需要設定dark 之後Text 使用textTheme.title, 這樣才會是白色  對比色
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: 'Hiragino Kaku Gothic ProN'),
      primaryTextTheme:
      base.primaryTextTheme.apply(fontFamily: 'Hiragino Kaku Gothic ProN'),
      accentTextTheme:
      base.accentTextTheme.apply(fontFamily: 'Hiragino Kaku Gothic ProN'));
}