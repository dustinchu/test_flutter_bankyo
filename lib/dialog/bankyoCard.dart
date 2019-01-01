import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:test_flutter_bankyo/utf/course.dart';
import 'package:test_flutter_bankyo/utf/dialogResult.dart';
import 'package:test_flutter_bankyo/utf/audioplayer.dart';
import 'package:test_flutter_bankyo/utf/bankyoApi.dart';

class ShowDialog {
  ShowDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogContent();
        });
  }
}

class DialogContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DialogContentState();
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
  var titleName = ListLength.coursePostsList[dataSet].name;

  //獲取輸入數值使用的控制器
  final myController = TextEditingController();

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

    DialogResult.result=true;

    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }
  //初始化 會自動執行
  @override
  void initState() {
    DialogResult.result=false;
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
  Widget build(BuildContext context) {



    //亂數顯示內容或標題
    if (dataRandom == true) {
      titleName = ListLength.coursePostsList[dataSet].name;
    } else {
      titleName = ListLength.coursePostsList[dataSet].body;
    }
    TextTheme textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100.0))),
      contentPadding: EdgeInsets.only(top: 1.0),
      content: Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 70.0,
              child: Center(
                  child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          randomvoid();
                        });
                      },
                    ),
                  ),
                  //標題
                  Expanded(
                      flex: 2,
                      child: Text(
                        '${titleName}',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: icon,
                      onPressed: isPlaying
                          ? null
                          : () {
                              //判斷播放狀態
                              if (isPlayControl) {
                                //url.encodeFull 內建包  將String 轉成urlencode
                                play(bankyoResource.playUrl +
                                    Uri.encodeFull(ListLength
                                        .coursePostsList[dataSet].body));
                                isPlayControl = false;
                              } else {
                                stop();
                                isPlayControl = true;
                              }
                            },
                    ),
                  ),
                ],
              )),
            ),
            //分隔線
            Divider(
              color: Colors.grey,
              height: 4.0,
            ),
            Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          hintText: "請輸入答案",
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          result,
                          style: textTheme.caption,
                          textAlign: TextAlign.end,
                        )),
                  ],
                )),
            Divider(
              color: Colors.grey,
              height: 4.0,
            ),
            InkWell(
              child: Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: new InkWell(
                          child: Text(
                            "關閉",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                           Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.white30,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                      new Expanded(
                        child: new InkWell(
                          child: new Text(
                            "確定",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
//                                    if (dataRandom) {
//                                      titleName = ListLength.coursePostsList[dataSet].name;
//                                    } else {
//                                      titleName = ListLength.coursePostsList[dataSet].body;
//                                    }
                            if (dataRandom) {
                              if (ListLength.coursePostsList[dataSet].body ==
                                  myController.text) {
                                result = "正確";
                                //正確將錯誤的次數歸零
                                errorCount = 0;
                                setState(() {
                                  randomvoid();
                                });
                              } else {
                                setState(() {
                                  //錯誤要將次數＋1比較分辨在次點擊是否有錯誤
                                  errorCount += 1;
                                  result = "答案錯誤" + '${errorCount}' + '次';
                                });
                              }
                            } else {
                              if (ListLength.coursePostsList[dataSet].name ==
                                  myController.text) {
                                result = "正確";
                                //正確將錯誤的次數歸零
                                errorCount = 0;
                                setState(() {
                                  randomvoid();
                                });
                              } else {
                                setState(() {
                                  //錯誤要將次數＋1比較分辨在次點擊是否有錯誤
                                  errorCount += 1;
                                  result = "答案錯誤" + '${errorCount}' + '次';
                                });
                              }
                            }
//                                    state(() {
//                                      randomvoid();
//                                    });
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

void randomvoid() {
  //讀取SaveLength.length全局變數list長度
  dataSet = random.nextInt(ListLength.length);
  dataRandom = random.nextBool();
}
