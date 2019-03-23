import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/describeItemPost.dart';
import 'package:flutter/foundation.dart';
import 'package:test_flutter_bankyo/utf/describeCardItemModel.dart';
import 'package:test_flutter_bankyo/utf/audioplayer.dart';
import 'dart:async';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:test_flutter_bankyo/utf/addTitleBody.dart';

typedef void OnError(Exception exception);

enum PlayerState { stopped, playing }

class DescribeItemBodyPosts extends StatefulWidget {
  final List<DescribeItemPosts> posts;
  final String appbarTitle;
  final int cardIndex;

  DescribeItemBodyPosts({Key key, this.posts, this.appbarTitle, this.cardIndex})
      : super(key: key);

  @override
  _DescribeItemBodyPostsPosts createState() =>
      new _DescribeItemBodyPostsPosts(posts, appbarTitle, cardIndex);
}

class _DescribeItemBodyPostsPosts extends State<DescribeItemBodyPosts>
    with TickerProviderStateMixin {
  _DescribeItemBodyPostsPosts(this.posts, this.appbarTitle, this.cardIndex);

  final int cardIndex;
  final String appbarTitle;
  final List<DescribeItemPosts> posts;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;

  //判斷二次點擊 沒撥放完在點擊直接關閉 true=還沒播放  播放中false
  bool isPlayControl = true;

  //當點擊後 會將點擊的position存進來
  int isPostsID;

  //判斷點擊上面還是點擊下面listView
  bool isIconControl = false;

  @override
  Icon iconStatus(int position, bool iconControl) {
    //先判斷是標題 還是下方listView  True=是標題的播放被點擊 標題 bool會傳true
    if (iconControl) {
      //如果點擊下面listView他會回傳false 回傳true代表是點擊標題播放
      if (isIconControl) {
        //如果沒播放 會是true 播放會是false
        if (isPlayControl) {
          return Icon(Icons.play_arrow);
        } else {
          return Icon(Icons.stop);
        }
      } else {
        //如果不是點擊標題這個 直接返回播放
        return Icon(Icons.play_arrow);
      }
    } else {
      //如果一樣 代表是那個點擊的listView
      if (isPostsID == position) {
        if (isPlayControl) {
          return Icon(Icons.play_arrow);
        } else {
          return Icon(Icons.stop);
        }
        //不一樣代表點擊的不是那個listView 不變更
      } else {
        return Icon(Icons.play_arrow);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  //關閉事件
  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = new AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        //播放結束 刷新頁面
        onComplete();
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  Future play(url) async {
    await audioPlayer.play(url);
    setState(() {});
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      isPlayControl = true;
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
    position = duration;
    isPlayControl = true;
  }

  //將播放的漢字取消 回傳字串播放使用
  String playString(String text) {
    String playstr = '';
    var strList;
    //將傳進來的資料用空白分開
    strList = text.split(" ");
    for (int i = 0; i < strList.length; i++) {
      //在把分開的內容用＆分開 如果有＆代表漢字 需要上面顯示他的片假名
      var list = strList[i].split("&");
      if (list.length > 1) {
        playstr += list[0];
      } else {
        playstr += strList[i];
      }
    }
    print(playstr);
    return playstr;
  }

// //將漢字與片假名 存成Column
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    var exampleTitle = posts[cardIndex].exampleTitle.split(",");
    var exampleBody = posts[cardIndex].exampleBody.split(",");

//    //將漢字與片假名 存成Column
//    List<Widget> createChildrenTexts(String text) {
//      List<Widget> childrenTexts = List<Widget>();
//      var strList;
//      //將傳進來的資料用空白分開
//      strList = text.split(" ");
//      for (int i = 0; i < strList.length; i++) {
//        //在把分開的內容用＆分開 如果有＆代表漢字 需要上面顯示他的片假名
//        var list = strList[i].split("&");
//        if (list.length > 1) {
//          childrenTexts.add(Column(
//            children: <Widget>[
//              Text(list[0], style: textTheme.caption),
//              Text(list[1], style: textTheme.title)
//            ],
//          ));
//        } else {
//          childrenTexts.add(Column(
//            children: <Widget>[
//              Text(""),
//              Text(strList[i], style: textTheme.title)
//            ],
//          ));
//        }
//      }
//      return childrenTexts;
//    }

    return new Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/bg_exercise.png"),
            fit: BoxFit.cover,
          ),
          color: cardItemModel[cardIndex].backroundColor),
      child: Scaffold(
        //透明背景不然會遮蓋container
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
        appBar: new AppBar(
          title: new Text(
            '${appbarTitle}',
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
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 42.0, vertical: 2.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 2.0),
                              child: Text(
                                //標題名稱
                                posts[cardIndex].name,
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 1.0),
                              title: Row(
                                children: createChildrenTexts(
                                    context, posts[cardIndex].titleName, 0, 1,1),
                              ),
                              subtitle: Text(posts[cardIndex].titleBody,
                                  style: TextStyle(color: Colors.white)),
                              trailing: Column(
                                children: <Widget>[
                                  Text(''),
                                  IconButton(
                                      icon: iconStatus(999, true),
                                      onPressed: isPlaying
                                          ? null
                                          : () {
                                              if (isPlayControl) {
                                                //判斷是上面標題還是下面listView
                                                isIconControl = true;
                                                //儲存點擊的id
                                                isPostsID = 999;
                                                //播放器狀態
                                                isPlayControl = false;
                                                //url.encodeFull 內建包  將String 轉成urlencode
                                                play(url[0].playUrl +
                                                    Uri.encodeFull(playString(
                                                        posts[cardIndex]
                                                            .titleName)));
                                              } else {
                                                stop();
                                              }
                                            }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      //怕手機尺寸太小高度不夠 說明這些 固定高度 如果自太多 讓他可以滑動
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 42.0, vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    //標題名稱
                                    Text('說明', style: textTheme.title),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 10.0, 0.0, 12.0),
                                      child: Divider(
                                        color: Colors.white30,
                                        height: 6.0,
                                      ),
                                    ),
                                    Text(posts[cardIndex].body,style:  TextStyle(color: Colors.white70),),
                                  ],
                                ));
                          }),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 42.0, vertical: 2.0),
                        child: ListView.builder(
                          itemCount: exampleTitle.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, position) {
                            return Container(
                              padding: new EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 6.0),
                              margin: EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Wrap(

                                            children: createChildrenTexts(
                                                context,
                                                exampleTitle[position],
                                                0,
                                                1,1),alignment: WrapAlignment.start),
                                        Text(""),
                                        Row(
                                          children: <Widget>[
                                            Text(exampleBody[position],
                                                textAlign: TextAlign.left,
                                                style:
                                                TextStyle(color: Colors.white,fontSize: 12)),
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      icon: iconStatus(position, false),
                                      onPressed: isPlaying
                                          ? null
                                          : () {
                                              if (isPlayControl) {
                                                //判斷是上面標題還是下面listView
                                                isIconControl = false;
                                                //儲存點擊的id
                                                isPostsID = position;
                                                //播放器狀態
                                                isPlayControl = false;
                                                //url.encodeFull 內建包  將String 轉成urlencode
                                                play(url[0].playUrl +
                                                    Uri.encodeFull(playString(
                                                        exampleTitle[
                                                            position])));
                                              } else {
                                                stop();
                                              }
                                            }),
                                ],
                              ),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.2)),
                                ),
                                color: Color.fromRGBO(0, 0, 0, 0.0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
