

class CoursePosts {
  final String name;
  final String body;

  CoursePosts({this.name,this.body});

  factory CoursePosts.fromJson(Map<String, dynamic> json) {
    return CoursePosts(
      name: json['name'] as String,
      body: json['body'] as String,
    );
  }
}