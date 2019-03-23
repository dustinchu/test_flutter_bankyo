import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:test_flutter_bankyo/posts/exerciseItemPost.dart';
import 'dart:math';

class ExerciseItemPosts extends StatefulWidget {
  final int clickId;
  final Future<List<ExerciseItemPost>> exerciseItemJSon;

  ExerciseItemPosts({Key key, this.clickId, this.exerciseItemJSon})
      : super(key: key);

  @override
  _ExerciseItemPost createState() =>
      new _ExerciseItemPost(clickId, exerciseItemJSon);
}

class _ExerciseItemPost extends State<ExerciseItemPosts>
    with TickerProviderStateMixin {
  _ExerciseItemPost(this.clickID, this.exerciseItemJSon);

  final int clickID;
  final Future<List<ExerciseItemPost>> exerciseItemJSon;

  final random = new Random();

  @override
  Widget build(BuildContext context) {

    void Answer(context, String answer, int selectID) {
      if (int.parse(answer) == selectID) {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
          content: new Text('正確'),
        ));
        setState(() {});
      } else {
        Scaffold.of(context)
            .showSnackBar(new SnackBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
          content: new Text('錯誤'),
        ));
      }
    }

    TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    return
      //json lodeing icon conter
      Align(
        alignment: FractionalOffset.center,
        //等json回傳完畢再顯示
        child: FutureBuilder<List<ExerciseItemPost>>(
          future: exerciseItemJSon,
          builder: (context, snapshot) {
            //錯誤返回一個部件
            if (snapshot.hasError) {
              return Text("網路連線異常");
            }
            if (snapshot.connectionState == ConnectionState.done) {

              int dataSet = random.nextInt(snapshot.data.length);

              var resultList = snapshot.data[dataSet].resultSelect.split(',');

              var answer = snapshot.data[dataSet].answer;

              return new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("images/bg_exercise.png"),
                    fit: BoxFit.cover,
                  ),
//          color: cardItemModel[clickID].backroundColor
                ),
                child: Scaffold(
                  //透明背景不然會遮蓋container
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
                  appBar: new AppBar(
                    title: new Text(
                      '練習',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    //標題透明
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
                    centerTitle: true,
                    elevation: 0.0,
                  ),
                  body: new Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Align(
                              alignment: FractionalOffset.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 60.0,
                                ),
                                child: Text(
                                    snapshot.data[dataSet].topic.toString()),
                              )),
                        ),
                        Divider(
                          color: Colors.white30,
                          height: 6.0,
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  //保持一樣高度
                                  child: IntrinsicHeight(
                                    child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  Answer(context, answer, 0);
                                                },
                                                child: Center(
                                                  child:
                                                  Text(resultList.length > 0
                                                      ? resultList[0]
                                                      : ""),
                                                )),
                                          ),
                                          Container(
                                            width: 1.0,
                                            color: Colors.white30,
                                            margin: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  Answer(context, answer, 1);
                                                },
                                                child: Center(
                                                  child:
                                                  Text(resultList.length >= 1
                                                      ? resultList[1]
                                                      : ""),
                                                )),
                                          ),
                                        ]),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white30,
                                  height: 6.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IntrinsicHeight(
                                    child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  Answer(context, answer, 2);
                                                },
                                                child: Center(
                                                  child: Text(
                                                      resultList.length >= 2
                                                          ? resultList[2]
                                                          : ""),
                                                )),
                                          ),
                                          Container(
                                            width: 1.0,
                                            color: Colors.white30,
                                            margin: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  Answer(context, answer, 3);
                                                },
                                                child: Center(
                                                  child: Text(
                                                      resultList.length >= 3
                                                          ? resultList[3]
                                                          : ""),
                                                )),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }
            else
            return
            CircularProgressIndicator
            (
            );
          },
        ),

      );
  }
}


