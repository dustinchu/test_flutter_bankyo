import 'package:flutter/material.dart';
import 'package:test_flutter_bankyo/posts/describePost.dart';
import 'package:test_flutter_bankyo/screen/describeItemScreen.dart';
class DescribeListViewPosts extends StatelessWidget {
  final List<DescribePosts> posts;

  DescribeListViewPosts({Key key, this.posts}) : super(key: key);

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
                    title: Text(
                      '${posts[position].name}',
                      style: textTheme.title,
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.white, size: 30.0),
                    //傳入選擇的ID 跟選擇的名稱
                    onTap: () => _onTapItem(
                        context, posts[position]),
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

  void _onTapItem(BuildContext context, DescribePosts post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DescribeItem(post.name, post.id)));
//    Scaffold.of(context).showSnackBar(new SnackBar(
//        content: new Text(post.id.toString() + ' - ' + post.title)));
  }
}
