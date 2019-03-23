

class DescribePosts {
  final int id;
  final String name;

  DescribePosts({this.id, this.name});

  factory DescribePosts.fromJson(Map<String, dynamic> json) {
    return DescribePosts(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}