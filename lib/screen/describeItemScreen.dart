import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/describeItemPost.dart';
import 'package:test_flutter_bankyo/posts/urlPost.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:test_flutter_bankyo/models/describeItemListView.dart';

class DescribeItemScreen extends StatefulWidget {
  DescribeItemScreen(this.posts, this.itemName);
  final String itemName;
  final Future<List<DescribeItemPosts>> posts;

  @override
  _DescribeItemScreenState createState() => new _DescribeItemScreenState(posts, itemName);
}

class _DescribeItemScreenState extends State<DescribeItemScreen> {
  _DescribeItemScreenState(this.posts , this.itemName);

  final Future<List<DescribeItemPosts>> posts;
  final String itemName;
  @override
  build(BuildContext context) {
    return new Container(
      child: new Container(

        child: new Scaffold(
          //漸層背景在上一層
          backgroundColor: Color.fromRGBO(29, 29, 38, 0.2),
          body: FutureBuilder<List<DescribeItemPosts>>(
            future: posts,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? DescribeItemListViewPosts(posts: snapshot.data ,appbarTitle: itemName,)
                  : Center(child: CircularProgressIndicator());
            },
          ),
//          bottomNavigationBar: MakeBottonScreenState(),
        ),
      ),
    );
  }
}




class DescribeItem extends StatelessWidget {
  final describeSelectId;
  final itemName;

  DescribeItem( this.itemName,this.describeSelectId);

  @override
  Widget build(BuildContext context) {
    final Future<List<DescribeItemPosts>> posts =
    fetchPosts(http.Client(),  describeSelectId);
    return Scaffold(
        body: DescribeItemScreen(posts,itemName));
  }
}

//撈取課程資料 回傳一個json
Future<List<DescribeItemPosts>> fetchPosts(http.Client client, describeSelectId) async {
  final response = await client.get(url[0].describeItemListViewUrl+ '${describeSelectId}');
  return compute(parsePosts, response.body);
}

List<DescribeItemPosts> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<DescribeItemPosts>((json) => DescribeItemPosts.fromJson(json)).toList();
}


