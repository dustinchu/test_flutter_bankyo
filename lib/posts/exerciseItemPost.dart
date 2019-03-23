// To parse this JSON data, do
//
//     final exerciseItemPost = exerciseItemPostFromJson(jsonString);

import 'dart:convert';

List<ExerciseItemPost> exerciseItemPostFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<ExerciseItemPost>.from(jsonData.map((x) => ExerciseItemPost.fromJson(x)));
}

String exerciseItemPostToJson(List<ExerciseItemPost> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class ExerciseItemPost {
  String topic;
  String resultSelect;
  String answer;
  int exercisesId;

  ExerciseItemPost({
    this.topic,
    this.resultSelect,
    this.answer,
    this.exercisesId,
  });

  factory ExerciseItemPost.fromJson(Map<String, dynamic> json) => new ExerciseItemPost(
    topic: json["topic"],
    resultSelect: json["resultSelect"],
    answer: json["answer"],
    exercisesId: json["exercises_id"],
  );

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "resultSelect": resultSelect,
    "answer": answer,
    "exercises_id": exercisesId,
  };
}
