import 'package:flutter/material.dart';

class ShowDialog {
  ShowDialog(BuildContext context) {
    // flutter defined function
    showDialog(
        context: context,
        builder: (BuildContext context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                  ),
                  SizedBox(
                    height: 70.0,
                    child: Center(
                      child: Text(
                        "勉強",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  //分隔線
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "請輸入答案",
                        border: InputBorder.none,
                      ),
                      maxLines: 1,
                    ),
                  ),
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
                              child:Text(
                                "關閉",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                          ),


                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.white30,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                          new Expanded(
                            child:Text(
                              "確定",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
