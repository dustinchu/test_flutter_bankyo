import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/newsBodyPost.dart';
import 'package:test_flutter_bankyo/posts/newsTitlePost.dart';
import 'package:test_flutter_bankyo/models/newsBodyView.dart';
import 'package:test_flutter_bankyo/utf/jsonText.dart';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:http/http.dart' as http;
class NewsBodyScreen extends StatefulWidget {
  final List<NewsTitlePosts> posts;
  final int clickID;

  NewsBodyScreen({Key key, this.posts,this.clickID}) : super(key: key);
  @override
  _NewsBodyScreenState createState() => new _NewsBodyScreenState(posts,clickID);

}

class _NewsBodyScreenState extends State<NewsBodyScreen> {
  _NewsBodyScreenState(this.posts, this.clickId);

  final int clickId;
  final List<NewsTitlePosts> posts;


  @override
  build(BuildContext context) {
    //切換到下一個頁面 再退回來 他才會跑這段  可能要試一下ｉｎｉｔ
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

              body: NewsBodyViewPosts(postsTitle: posts,
                  clickId: clickId,
                  newsBodyJSon: FetchBodyJSON(
                      http.Client(),  posts, clickId)),
            )));
  }

}
Future<TitleBody> FetchBodyJSON(http.Client client, List<NewsTitlePosts> posts,int clickID) async {
  final response = await client.get(url[0].newsBody+posts[clickID].url);
  return titleBodyFromJson(response.body);
}