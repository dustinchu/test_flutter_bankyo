import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/screen/homeScreen.dart';
import 'package:test_flutter_bankyo/source/bankyo_api.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: _buildTheme(),
      //將url連線資料傳過去
      home: new HomeScreen(bankyoResource),
      debugShowCheckedModeBanner: true,
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
