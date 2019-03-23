

class CoursePosts {
  final String title;
  final String type;
  final String body;
  final String exampleTitle;
  final String exampleBody;

  CoursePosts({this.title,this.type,this.body,this.exampleTitle,this.exampleBody});

  factory CoursePosts.fromJson(Map<String, dynamic> json) {
    return CoursePosts(
      title: json['title'] as String,
      type: json['type'] as String,
      body: json['body'] as String,
      exampleTitle: json['exampleTitle'] as String,
      exampleBody: json['exampleBody'] as String,
    );
  }
}