// To parse this JSON data, do
//
//     final tagsWithMails = tagsWithMailsFromJson(jsonString);

import 'dart:convert';

import 'package:pailmail/models/tags/tag.dart';

TagsWithMails tagsWithMailsFromJson(String str) =>
    TagsWithMails.fromJson(json.decode(str));

String tagsWithMailsToJson(TagsWithMails data) => json.encode(data.toJson());

class TagsWithMails {
  List<Tag>? tags;

  TagsWithMails({
    this.tags,
  });

  factory TagsWithMails.fromJson(Map<String, dynamic> json) => TagsWithMails(
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
