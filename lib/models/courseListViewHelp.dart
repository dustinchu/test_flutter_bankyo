import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:test_flutter_bankyo/utf/course.dart';
import 'package:test_flutter_bankyo/utf/dialogResult.dart';
import 'package:test_flutter_bankyo/utf/audioplayer.dart';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:test_flutter_bankyo/posts/coursePost.dart';
import 'package:test_flutter_bankyo/utf/addTitleBody.dart';

class HelpShowDialog {
  HelpShowDialog(BuildContext context, List<CoursePosts> posts, index) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogContent(
            posts: posts,
            index: index,
          );
        });
  }
}

class DialogContent extends StatefulWidget {
  final List<CoursePosts> posts;
  final int index;

  DialogContent({Key key, this.posts, this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new DialogContentState(posts, index);
}

final random = new Random();
//亂數數值
int dataSet = 1;
//判斷顯示標題還是內容
bool dataRandom = true;
//顯示答題結果
String result = '';
//錯誤次數
int errorCount = 0;

typedef void OnError(Exception exception);

enum PlayerState { stopped, playing }

class DialogContentState extends State<DialogContent> {
  DialogContentState(this.posts, this.postsIndex);

  final List<CoursePosts> posts;
  final int postsIndex;

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;

//判斷二次點擊 沒撥放完在點擊直接關閉 true=還沒播放  播放中false
  bool isPlayControl = true;

//當點擊後 會將點擊的position存進來
  int isPostsID;

  bool isIcon = true;

  //當initState使用 只執行一次
  bool init = true;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  var icon = Icon(Icons.play_arrow);

  //畫面結束 關閉state 會自動執行
  @override
  void dispose() {
    PlayStatus.CourseDialog = true;

    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  //初始化 會自動執行
  @override
  void initState() {
    PlayStatus.CourseDialog = false;
    super.initState();
    initAudioPlayer();
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
    icon = Icon(Icons.play_arrow);
    position = duration;
    isPlayControl = true;
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
        onComplete();
        //播放結束 刷新頁面
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
    setState(() {
      icon = Icon(Icons.stop);
    });
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
      icon = Icon(Icons.play_arrow);
    });
  }

  @override
  Icon iconStatus(position) {
    //第一次 isIcon = false
    if (isIcon) {
      //判斷點擊的是否一致 一致改變icon不一樣代表不是點擊的item
      if (position == isPostsID) {
//        print('${position}'+'${isPlayControl}');
        if (isPlayControl) {
          return Icon(Icons.play_arrow);
        } else {
          return Icon(Icons.stop);
        }
      } else {
        return Icon(Icons.play_arrow);
      }
    } else {
      isIcon = true;
      return Icon(Icons.play_arrow);
    }
  }

  @override
  Widget build(BuildContext context) {
    var bodyList = posts[postsIndex].exampleBody.split(",");
    var titleList = posts[postsIndex].exampleTitle.split(",");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 1.0),
      content: Container(
        height: height / 2,
        width: width,
        decoration: new BoxDecoration(
            //圓角
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            //背景漸層
            gradient: new LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                const Color.fromRGBO(33, 208, 253, 1.0),
                const Color.fromRGBO(238, 77, 185, 1.0),
              ],
              stops: [0.0, 1.0],
            )),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0, 25.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  ),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Wrap(
                            children: createChildrenTexts(
                                context, posts[0].title, 1, 0, 0)),
                      )),
                  Expanded(
                    flex: 1,
                    child: Text(""),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.white30,
              height: 6.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: bodyList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    title: Text(
                      titleList[index],
                      style: textTheme.subtitle,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
                      child: Text(bodyList[index]),
//                child: Text(posts[position].body+"("+posts[position].type+")",
//                    style: TextStyle(color: Colors.white)),
                    ),
                    trailing: IconButton(
                        icon: iconStatus(index),
                        onPressed: isPlaying
                            ? null
                            : () {
                                isPostsID = index;

                                //判斷播放狀態
                                if (isPlayControl) {
                                  //url.encodeFull 內建  將String 轉成urlencode
                                  isPlayControl = false;
                                  play(url[0].playUrl +
                                      Uri.encodeFull(titleList[index]));
                                } else {
                                  stop();
                                }
                              }),
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(255, 255, 255, 0.2)),
                    ),
                    color: Color.fromRGBO(0, 0, 0, 0.0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
