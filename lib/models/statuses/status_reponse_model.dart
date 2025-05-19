// To parse this JSON data, do
//
//     final statusResponseModel = statusResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:pailmail/models/statuses/status.dart';

StatusResponseModel statusResponseModelFromJson(String str) =>
    StatusResponseModel.fromJson(json.decode(str));

String statusResponseModelToJson(StatusResponseModel data) =>
    json.encode(data.toJson());

class StatusResponseModel {
  List<Status>? statuses;

  StatusResponseModel({
    this.statuses,
  });

  factory StatusResponseModel.fromJson(Map<String, dynamic> json) =>
      StatusResponseModel(
        statuses: json["statuses"] == null
            ? []
            : List<Status>.from(
                json["statuses"]!.map((x) => Status.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statuses": statuses == null
            ? []
            : List<dynamic>.from(statuses!.map((x) => x.toJson())),
      };
}
