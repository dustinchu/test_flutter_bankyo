// To parse this JSON data, do
//
//     final titleBody = titleBodyFromJson(jsonString);

import 'dart:convert';

TitleBody titleBodyFromJson(String str) {
  final jsonData = json.decode(str);
  return TitleBody.fromJson(jsonData);
}

String titleBodyToJson(TitleBody data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class TitleBody {
  String bodyText;

  TitleBody({
    this.bodyText,
  });

  factory TitleBody.fromJson(Map<String, dynamic> json) => new TitleBody(
    bodyText: json["bodyText"],
  );

  Map<String, dynamic> toJson() => {
    "bodyText": bodyText,
  };
}
