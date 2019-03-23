import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/utf/bankyoApi.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:test_flutter_bankyo/bottomNavigtion/bottomCustomTab.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelComeScreenState createState() => new _WelComeScreenState();
}

class _WelComeScreenState extends State<WelcomeScreen> {
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//  }
  int retry = 0;

  @override
  void initState() {
    super.initState();
    fetchPost(context);

//    Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, "/home"));
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [
                    const Color.fromRGBO(33, 208, 253, 1.0),
                    const Color.fromRGBO(238, 77, 185, 1.0),
                  ],
                  stops: [0.0, 1.0],
                ),
                image: new DecorationImage(
                    image: new AssetImage("images/bg_welcome.png"),
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Stantor",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold),
                      ),

//                        Padding(
//                          padding: EdgeInsets.only(top: 80.0),
//                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(top: 80.0),
//                        ),
//                        new Image.asset('images/bg_logo.png'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
//                      FutureBuilder<List<UrlPost>>(
//                        future: get,
//                        builder: (context, snapshot) {
//                          if (snapshot.hasData) {
////                            setState((){
//                              retry ++;
////                            });
//                            return Text("");
//                          } else if (snapshot.hasError) {
//                            return Text("${snapshot.error}");
//                          }
//
//                          return CircularProgressIndicator();
//                        },
//                      ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "On-line Learn \nFor Everyone",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Future<List<UrlPost>> fetchPost(context) async {
  final response =
      await http.Client().get('https://bankyou.herokuapp.com/urlList');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    urlPostFromJson(response.body);
//    print(exerciseJson[0].playUrl);
//    return exerciseJson;
    Navigator.pushNamed(context, "/home");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
