import 'dart:convert';

import 'package:pailmail/models/senders/sender.dart';

SenderResponseModel senderResponseModelFromJson(String str) =>
    SenderResponseModel.fromJson(json.decode(str));

String senderResponseModelToJson(SenderResponseModel data) =>
    json.encode(data.toJson());

class SenderResponseModel {
  String? message;
  List<Sender>? sender;

  SenderResponseModel({
    this.message,
    this.sender,
  });

  factory SenderResponseModel.fromJson(Map<String, dynamic> json) =>
      SenderResponseModel(
        message: json["message"],
        sender: json["sender"] == null
            ? []
            : List<Sender>.from(json["sender"]!.map((x) => Sender.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sender": sender == null
            ? []
            : List<dynamic>.from(sender!.map((x) => x.toJson())),
      };
}
