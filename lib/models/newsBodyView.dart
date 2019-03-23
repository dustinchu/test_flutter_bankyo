import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/newsTitlePost.dart';
import 'package:test_flutter_bankyo/utf/jsonText.dart';
import 'package:flutter/foundation.dart';
import 'package:test_flutter_bankyo/utf/audioplayer.dart';
import 'dart:async';
import 'package:test_flutter_bankyo/utf/addTitleBody.dart';
import 'package:test_flutter_bankyo/posts/newsBodyPost.dart';

typedef void OnError(Exception exception);


class NewsBodyViewPosts extends StatefulWidget {
  final List<NewsTitlePosts> postsTitle;
  final int clickId;
  final Future<TitleBody> newsBodyJSon;
  NewsBodyViewPosts({Key key, this.postsTitle, this.clickId,this.newsBodyJSon}) : super(key: key);

  @override
  _NewsBodyViewPosts createState() =>
      new _NewsBodyViewPosts(postsTitle, clickId,newsBodyJSon);
}

class _NewsBodyViewPosts extends State<NewsBodyViewPosts>
    with TickerProviderStateMixin {
  _NewsBodyViewPosts(this.postsTitle, this.clickID,this.newsBodyJSon);
  final int clickID;
  final List<NewsTitlePosts> postsTitle;
  final Future<TitleBody> newsBodyJSon;
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  //判斷點擊  true=還沒播放  播放中false
  bool isPlayControl = true;

  @override
  Icon iconStatus() {
    //第一次 isIcon = false
    if (isPlayControl) {
      return Icon(Icons.play_arrow);
    } else {
      return Icon(Icons.pause);
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
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        duration = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    });
  }

  Future play(Url) async {
    await audioPlayer.play(Url);
    isPlayControl = false;
    setState(() {});
  }

  Future pause() async {
    await audioPlayer.pause();
    isPlayControl = true;
    setState(() {});
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    position = duration;
    isPlayControl = true;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
            'ニュース',
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
           Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("見出し",style: textTheme.title,),
                      Divider(
                        color: Colors.white30,
                        height: 15.0,
                      ),
                    ],
                  ),

                  Wrap(

                  children:createChildrenTexts(context, postsTitle[clickID].title.toString(), 1, 0,1),
                ),
              ],
            )),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 60.0,vertical: 10.0 ),
             child:
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text("內容",style: textTheme.title,),
                 Divider(
                   color: Colors.white30,
                   height: 15.0,
                 ),
               ],
             ),
           ),



           Expanded(
                flex: 2,
                child: new ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 60.0,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[


                              FutureBuilder<TitleBody>(
                                future: newsBodyJSon,
                                builder: (context, snapshot){
                                  //錯誤返回一個部件
                                  if(snapshot.hasError){
                                    return Text("網路連線異常");
                                  }
                                  if(snapshot.connectionState == ConnectionState.done)
                                    return  Wrap(
                                    children: createChildrenTexts(context,snapshot.data.bodyText, 1, 0,1),
                                  );
                                  else
                                    return CircularProgressIndicator();
                                },

                              ),

                            ],
                          ));
                    }),
              ),
              Divider(
                color: Colors.white30,
                height: 6.0,
              ),
              _buildPlayer(),
            ],
          ),
        ),
      ),
    );
  }



  //音樂播放
  Widget _buildPlayer() => new Container(
      padding: new EdgeInsets.all(16.0),
      child: new Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: <Widget>[
            new Text(
                position != null
                    ? "${positionText ?? ''} "
                    : duration != null ? durationText : '',
                style: new TextStyle(fontSize: 10.0,color:  Colors.white54)),
            Expanded(
              flex: 1,
              child: duration == null
                  ? new Slider(value: 0, min: 0.0, max: 100,activeColor: Colors.white,inactiveColor: Colors.white30,)
                  : new Slider(
                      value: position?.inMilliseconds?.toDouble() ?? 0.0,
                      onChanged: (double value) =>
                          audioPlayer.seek((value / 1000).roundToDouble()),
                      min: 0.0,
                      max: duration.inMilliseconds.toDouble(),activeColor: Colors.white70,inactiveColor: Colors.white30),
            ),
            new Text(
                position != null
                    ? "${durationText ?? ''}"
                    : duration != null ? durationText : '',
                style: new TextStyle(fontSize: 10.0,color:  Colors.white54))
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new IconButton(
                onPressed: () => mute(true),
                icon: new Icon(Icons.headset_off),
                color: Colors.white70),
            new IconButton(
                onPressed: () {
                  if (isPlayControl)
                    play(postsTitle[clickID].playUrl);
                  else
                    pause();
                },
                icon: iconStatus(),
                color: Colors.white70),
            new IconButton(
                onPressed: () => mute(false),
                icon: new Icon(Icons.headset),
                color: Colors.white70),
          ],
        ),
      ]));
}
