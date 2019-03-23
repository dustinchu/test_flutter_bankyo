import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/newsTitlePost.dart';
import 'package:flutter/foundation.dart';
import 'package:test_flutter_bankyo/utf/describeCardItemModel.dart';
import 'package:test_flutter_bankyo/screen/newsBodyScreen.dart';
import 'package:test_flutter_bankyo/utf/addTitleBody.dart';
class NewsTitleListViewPosts extends StatefulWidget {
  final List<NewsTitlePosts> posts;

  NewsTitleListViewPosts({Key key, this.posts}) : super(key: key);

  @override
  _NewsTitleListViewPosts createState() =>
      new _NewsTitleListViewPosts(posts, "新聞");
}

class _NewsTitleListViewPosts extends State<NewsTitleListViewPosts>
    with TickerProviderStateMixin {
  _NewsTitleListViewPosts(this.posts, this.appbarTitle);

  final String appbarTitle;
  final List<NewsTitlePosts> posts;

  var cardIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {



    return new Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("images/bg_exercise.png"),
            fit: BoxFit.cover,
          ),
          color: currentColor),
      child: Scaffold(
        //透明背景不然會遮蓋container
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
        appBar: new AppBar(
          title: new Text(
            '${appbarTitle}',
            style: TextStyle(fontSize: 16.0),
          ),
          //appbar 透明
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
          centerTitle: true,
//        actions: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(right: 16.0),
//            child: Icon(Icons.search),
//          ),
//        ],
          elevation: 0.0,
        ),
        body: new Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(""),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 64.0, vertical: 2.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 16.0, 0.0, 12.0),
                                child: Text(
                                  "これは今日のニュースです",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Wrap(
                                children:
                                createChildrenTexts(context,posts[cardIndex].title,1,0,1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(""),
                      ),
                    ]),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(""),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 64.0, vertical: 15.0),
                      child: Text(
                        "更新時間: ${posts[cardIndex].time}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        flex: 6,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: posts.length,
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                            return new InkWell(
                              //顯示內容頁面
                              onTap: () {
                                _onTapItem(context, position);
                              },
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                              image: new NetworkImage(
                                                  posts[position].img),
                                              fit: BoxFit.cover)),

                                      width: 250.0,

                                      //怕手機尺寸太小高度不夠 說明這些 固定高度 如果自太多 讓他可以滑動
                                      child: Container(
                                        height: 100,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                                onHorizontalDragEnd: (details) {
                                  animationController = AnimationController(
                                      vsync: this,
                                      duration: Duration(milliseconds: 500));
                                  curvedAnimation = CurvedAnimation(
                                      parent: animationController,
                                      curve: Curves.fastOutSlowIn);
                                  animationController.addListener(() {
                                    setState(() {
                                      currentColor =
                                          colorTween.evaluate(curvedAnimation);
                                    });
                                  });

                                  if (details.velocity.pixelsPerSecond.dx > 0) {
                                    if (cardIndex > 0) {
                                      cardIndex--;
                                      colorTween = ColorTween(
                                          begin: currentColor,
                                          end: cardItemModel[cardIndex]
                                              .backroundColor);
                                    }
                                  } else {
                                    if (cardIndex <  posts.length-1) {
                                      cardIndex++;
                                      colorTween = ColorTween(
                                          begin: currentColor,
                                          end: cardItemModel[cardIndex]
                                              .backroundColor);
                                    }
                                  }
                                  setState(() {
                                    scrollController.animateTo(
                                        (cardIndex) * 256.0,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn);
                                  });

                                  colorTween.animate(curvedAnimation);

                                  animationController.forward();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(""),
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

  void _onTapItem(BuildContext context, int position) {
//      //跳轉動畫！
    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) =>
        new NewsBodyScreen(
            posts: posts, clickID: position),
        transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: new SlideTransition(
              position: new Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0.0, 1.0),
              ).animate(secondaryAnimation),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 1000)));
  }
}

