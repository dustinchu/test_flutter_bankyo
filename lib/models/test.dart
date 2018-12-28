import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:test_flutter_bankyo/posts/coursePost.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/models/audioplayer.dart';
import 'package:test_flutter_bankyo/utf/bankyoApi.dart';
import 'dart:convert' show utf8;

typedef void OnError(Exception exception);

enum PlayerState { stopped, playing }

class AudioApp extends StatefulWidget {
  final List<CoursePosts> posts;

  AudioApp({Key key, this.posts}) : super(key: key);

  @override
  _AudioAppState createState() => new _AudioAppState(posts);
}

class _AudioAppState extends State<AudioApp> {
  bool isIcon = false;


  _AudioAppState(this.posts);

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  final List<CoursePosts> posts;

  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;

  //判斷二次點擊 沒撥放完在點擊直接關閉 true=還沒播放  播放中false
  bool isPlayControl = true;

  //當點擊後 會將點擊的position存進來
  int isPostsID;

  @override
  Icon iconStatus(position) {
    //第一次 isIcon = false
    if (isIcon) {
      //判斷點擊的是否一致 一致改變icon不一樣代表不是點擊的item
      if (position == isPostsID) {
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
  void initState() {
    super.initState();
    initAudioPlayer();
  }

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
        onComplete();
        //播放結束 刷新頁面
        setState(() {
          position = duration;
          isPlayControl = true;
        });
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

    });
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = new Duration();
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: posts.length,
          itemBuilder: (context, position) {
            TextTheme textTheme = Theme.of(context).textTheme;

            return Card(
                color: Color.fromRGBO(0, 0, 0, 0.0),
                //需設定0.0才會透明 不然listview有陰影
                elevation: 0.0,
//                margin: new EdgeInsets.symmetric(horizontal:5.0,vertical: 5.0),
                child: Container(
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    title: Text(
                      '${posts[position].name}',
                      style: textTheme.title,
                    ),
                    subtitle: Text(posts[position].body,
                        style: TextStyle(color: Colors.white)),
                    trailing: IconButton(
                        icon: iconStatus(position),
                        onPressed: isPlaying
                            ? null
                            : () {
                                isPostsID = position;
                                //判斷播放狀態
                                if (isPlayControl) {
                                  //url.encodeFull 內建包  將String 轉成urlencode
                                  play(bankyoResource.playUrl +
                                      Uri.encodeFull(posts[position].body));
                                  isPlayControl = false;
                                } else {
                                  stop();
                                  isPlayControl = true;
                                }
                              }),
                  ),
                  //底線

                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: Color.fromRGBO(255, 255, 255, 0.2)),
                    ),
                    color: Color.fromRGBO(0, 0, 0, 0.0),
                  ),
                ));
          }),
    );
  }
}


void _onTapItem(BuildContext context, String post) {
  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(post)));
}
