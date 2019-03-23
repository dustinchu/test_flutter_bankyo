// To parse this JSON data, do
//
//     final urlPost = urlPostFromJson(jsonString);

import 'dart:convert';

 List<UrlPost> url;

List<UrlPost> getUrl(){

  return url;
}

List<UrlPost> urlPostFromJson(String str) {
  final jsonData = json.decode(str);
  url=  List<UrlPost>.from(jsonData.map((x) => UrlPost.fromJson(x)));
}

String urlPostToJson(List<UrlPost> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class UrlPost {
  int id;
  String ver;
  String homeListViewUrl;
  String courseListViewUrl;
  String describeListViewUrl;
  String describeItemListViewUrl;
  String playUrl;
  String newsTtile;
  String newsBody;
  String exercise;
  String exerciseItem;

  UrlPost({
    this.id,
    this.ver,
    this.homeListViewUrl,
    this.courseListViewUrl,
    this.describeListViewUrl,
    this.describeItemListViewUrl,
    this.playUrl,
    this.newsTtile,
    this.newsBody,
    this.exercise,
    this.exerciseItem,
  });

  factory UrlPost.fromJson(Map<String, dynamic> json) => new UrlPost(
    id: json["id"],
    ver: json["ver"],
    homeListViewUrl: json["homeListViewUrl"],
    courseListViewUrl: json["courseListViewUrl"],
    describeListViewUrl: json["describeListViewUrl"],
    describeItemListViewUrl: json["describeItemListViewUrl"],
    playUrl: json["playUrl"],
    newsTtile: json["newsTtile"],
    newsBody: json["newsBody"],
    exercise: json["exercise"],
    exerciseItem: json["exerciseItem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ver": ver,
    "homeListViewUrl": homeListViewUrl,
    "courseListViewUrl": courseListViewUrl,
    "describeListViewUrl": describeListViewUrl,
    "describeItemListViewUrl": describeItemListViewUrl,
    "playUrl": playUrl,
    "newsTtile": newsTtile,
    "newsBody": newsBody,
    "exercise": exercise,
    "exerciseItem": exerciseItem,
  };
}
