import 'package:flutter/material.dart';

class AudioApp extends StatefulWidget {
  @override
  _AudioAppState createState() => new _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
        body:


        new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("images/bg_exercise.png"),
                fit: BoxFit.cover,
              ),
              gradient: new LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  const Color.fromRGBO(33, 208, 253, 1.0),
                  const Color.fromRGBO(238, 77, 185, 1.0),
                ],
                stops: [0.0, 1.0],
              )),

//              decoration: new BoxDecoration(
//
//                image: new DecorationImage(image: new AssetImage("images/bg_exercise.png"),
//                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
//                  fit: BoxFit.cover,),
//              ),
        ),
        new Column(

          children: <Widget>[
            //正確 錯誤
            Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "5",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "正確",
                            style: textTheme.caption,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.0,
                      color: Colors.white30,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    new Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "5",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "錯誤",
                            style: textTheme.caption,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Divider(
              color: Colors.white30,
              height: 4.0,
            ),

            Expanded(
              flex: 7,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Text("日本人はたぶんほとんど仕事に行きます！")],
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              color: Colors.white30,
              height: 4.0,
            ),

            //輸入
            Expanded(
              flex: 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "請輸入答案",
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ]),
            ),



            Divider(
              color: Colors.white30,
              height: 4.0,
            ),

            //按鈕
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      child: Text(
                        "SKIP",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 1.0,
                      color: Colors.white30,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    new Expanded(
                      child: new InkWell(
                        child: new Text(
                          "NEXT",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ],
    )

    );
  }
}
