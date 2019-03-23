import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/describeItemPost.dart';
import 'package:flutter/foundation.dart';
import 'package:test_flutter_bankyo/utf/describeCardItemModel.dart';
import 'package:test_flutter_bankyo/models/desctibeItemBody.dart';
import 'package:intl/intl.dart';

class DescribeItemListViewPosts extends StatefulWidget {
  final List<DescribeItemPosts> posts;
  final String appbarTitle;

  DescribeItemListViewPosts({Key key, this.posts, this.appbarTitle})
      : super(key: key);

  @override
  _DescribeItemListViewPosts createState() =>
      new _DescribeItemListViewPosts(posts, appbarTitle);
}

class _DescribeItemListViewPosts extends State<DescribeItemListViewPosts>
    with TickerProviderStateMixin {
  _DescribeItemListViewPosts(this.posts, this.appbarTitle);

  final String appbarTitle;
  final List<DescribeItemPosts> posts;

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
    TextTheme textTheme = Theme.of(context).textTheme;
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
                flex: 1,
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
                                  "こんにちは",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                "これらはとても素晴らしく見えます.",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "今日の任務を完成ます.",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
                        "今日 : ${new DateFormat.yMMMd().format(new DateTime.now())}",
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
                            //用-分開標題名稱 顯示在卡面的標題
                            var listViewTitleText =
                                posts[position].name.split('-');

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
                                            image: new AssetImage(
                                                "images/bg_exercise.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          color: currentColor),
                                      width: 250.0,

                                      //怕手機尺寸太小高度不夠 說明這些 固定高度 如果自太多 讓他可以滑動
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: 1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Icon(
                                                        cardItemModel[position]
                                                            .icon,
                                                        color: cardItemModel[
                                                                position]
                                                            .backroundColor,
                                                      ),
                                                      Text(listViewTitleText.length > 1
                                                          ? listViewTitleText[1]
                                                          : listViewTitleText[0]),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      '${posts[position].body}'),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 4.0),
                                                        child: Text(
                                                            "${posts[position].exampleBody.split(",").length} ミッション",
                                                            style: textTheme
                                                                .subtitle),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 4.0),
                                                        child: Text(
                                                          "${posts[position].name}",
                                                          style: TextStyle(
                                                              fontSize: 15.0),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
                                                            LinearProgressIndicator(
                                                          value: cardItemModel[
                                                                  position]
                                                              .taskCompletion,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
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
                                    if (cardIndex < posts.length - 1) {
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
            new DescribeItemBodyPosts(
                posts: posts, appbarTitle: appbarTitle, cardIndex: position),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
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
