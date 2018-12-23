

class HomePosts {
  final int id;
  final String name;

  HomePosts({this.id, this.name});

  factory HomePosts.fromJson(Map<String, dynamic> json) {
    return HomePosts(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}