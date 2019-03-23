import 'package:flutter/material.dart';

    //將漢字與片假名 存成Column
    List<Widget> createChildrenTexts(BuildContext context,String text,titleIndex,bodyIndex,type) {
      double fontSizeMin =0;
      double fontSizeMax =0;
      if(type ==1){

        fontSizeMax=12;
        fontSizeMin=8;
      }else{
        fontSizeMax = 18;
        fontSizeMin = 12;
      }


      TextTheme textTheme = Theme.of(context).textTheme;
      List<Widget> childrenTexts = List<Widget>();
      var strList;
      //將傳進來的資料用空白分開
      strList = text.split(" ");
      for (int i = 0; i < strList.length; i++) {

        //在把分開的內容用＆分開 如果有＆代表漢字 需要上面顯示他的片假名
        var list = strList[i].split("&");
        if (list.length > 1) {
          childrenTexts.add(Column(
            children: <Widget>[
              Text(list[titleIndex], style: TextStyle(fontSize: fontSizeMin,color: Colors.white54),),
              Text(list[bodyIndex], style: TextStyle(fontSize: fontSizeMax,color: Colors.white),)
            ],
          ));
        } else {
          childrenTexts.add(Column(
            children: <Widget>[
              Text(" ", style: TextStyle(fontSize: fontSizeMin,color: Colors.white54),),
              Text(strList[i], style: TextStyle(fontSize: fontSizeMax,color: Colors.white),)
            ],
          ));
        }
      }
      return childrenTexts;
    }


