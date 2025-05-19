// To parse this JSON data, do
//
//     final tagsOfMail = tagsOfMailFromJson(jsonString);

import 'dart:convert';

import 'package:pailmail/models/tags/tag.dart';

TagsOfMail tagsOfMailFromJson(String str) =>
    TagsOfMail.fromJson(json.decode(str));

String tagsOfMailToJson(TagsOfMail data) => json.encode(data.toJson());

class TagsOfMail {
  List<Tag>? tags;

  TagsOfMail({
    this.tags,
  });

  factory TagsOfMail.fromJson(Map<String, dynamic> json) => TagsOfMail(
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}
