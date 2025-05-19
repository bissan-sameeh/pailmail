// To parse this JSON data, do
//
//     final tagResponseModel = tagResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:pailmail/models/tags/tag.dart';

TagResponseModel tagResponseModelFromJson(String str) =>
    TagResponseModel.fromJson(json.decode(str));

String tagResponseModelToJson(TagResponseModel data) =>
    json.encode(data.toJson());

class TagResponseModel {
  List<Tag>? tags;

  TagResponseModel({
    this.tags,
  });

  factory TagResponseModel.fromJson(Map<String, dynamic> json) =>
      TagResponseModel(
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
