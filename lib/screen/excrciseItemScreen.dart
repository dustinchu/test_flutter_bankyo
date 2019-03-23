
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/exerciseItemPost.dart';
import 'package:test_flutter_bankyo/models/exerciseItem.dart';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:http/http.dart' as http;
class ExerciseItemScreen extends StatefulWidget {
  final int clickID;

 ExerciseItemScreen({Key key,this.clickID}) : super(key: key);
  @override
  _ExerciseItemScreenState createState() => new _ExerciseItemScreenState(clickID);

}

class _ExerciseItemScreenState extends State<ExerciseItemScreen> {
  _ExerciseItemScreenState(this.clickId);

  final int clickId;


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

              body: ExerciseItemPosts(
                  clickId: clickId,
                  exerciseItemJSon: FetchBodyJSON(
                      http.Client(), clickId)),
            )));
  }

}
Future<List<ExerciseItemPost>> FetchBodyJSON(http.Client client, int clickID) async {
  final response = await client.get(url[0].exerciseItem+clickID.toString());
  return exerciseItemPostFromJson(response.body);
}