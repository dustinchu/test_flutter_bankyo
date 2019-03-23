

class NewsTitlePosts {
  final String title;
  final String img;
  final String time;
  final String url;
  final String playUrl;

  NewsTitlePosts({this.title, this.img,this.time,this.url,this.playUrl});

  factory NewsTitlePosts.fromJson(Map<String, dynamic> json) {
    return NewsTitlePosts(
      title: json['title'] as String,
      img: json['img'] as String,
      time: json['time'] as String,
      url: json['url'] as String,
      playUrl: json['playUrl'] as String,
    );
  }
}