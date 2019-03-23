

class DescribeItemPosts {

  final String name;
  final String titleName;
  final String titleBody;
  final String exampleTitle;
  final String exampleBody;
  final String body;
  final int describes_id;
  DescribeItemPosts({this.describes_id, this.name, this.titleName, this.titleBody, this.exampleTitle, this.exampleBody, this.body});

  factory DescribeItemPosts.fromJson(Map<String, dynamic> json) {
    return DescribeItemPosts(

      name: json['name'] as String,
      titleName: json['titleName'] as String,
      titleBody: json['titleBody'] as String,
      exampleTitle: json['exampleTitle'] as String,
      exampleBody: json['exampleBody'] as String,
      body: json['body'] as String,
      describes_id: json['describes_id'] as int,
    );
  }
}