// To parse this JSON data, do
//
//     final exercisePost = exercisePostFromJson(jsonString);

import 'dart:convert';

List<ExercisePost> exercisePostFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ExercisePost>.from(jsonData.map((x) => ExercisePost.fromJson(x)));
}

String exercisePostToJson(List<ExercisePost> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class ExercisePost {
  int id;
  String topic;

  ExercisePost({
    this.id,
    this.topic,
  });

  factory ExercisePost.fromJson(Map<String, dynamic> json) => new ExercisePost(
    id: json["id"],
    topic: json["topic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic": topic,
  };
}
