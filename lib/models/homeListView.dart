import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/homePost.dart';
import 'package:test_flutter_bankyo/screen/courseScreen.dart';

class HomeListViewPosts extends StatelessWidget {
  final List<HomePosts> posts;

  HomeListViewPosts({Key key, this.posts}) : super(key: key);

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
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(Icons.autorenew, color: Colors.white),
                    ),
                    title: Text(
                      '${posts[position].name}',
                      style: textTheme.title,
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.white, size: 30.0),
                    //傳入選擇的ID 跟選擇的名稱
                    onTap: () => _onTapItem(
                        context, posts[position], posts[position].name),
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

  void _onTapItem(BuildContext context, HomePosts post, String ItemName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Course(post.id.toString(), ItemName)));
//    Scaffold.of(context).showSnackBar(new SnackBar(
//        content: new Text(post.id.toString() + ' - ' + post.title)));
  }
}
