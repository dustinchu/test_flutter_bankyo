import 'package:flutter/material.dart';

class TextFormFieldDemo extends StatefulWidget {

  @override
  _TextFormFieldDemoState createState() => new _TextFormFieldDemoState();
}

class _TextFormFieldDemoState extends State<TextFormFieldDemo> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Container(
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
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            Expanded(
            flex: 2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                   child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("日本人はたぶ")],
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
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Text("日本人はたぶんほとんど仕事に行きます！")],
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
              new Container(
                padding: new EdgeInsets.all(10.0),
                child: new TextField(
                  decoration: new InputDecoration(
                    hintText: "請輸入答案",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
