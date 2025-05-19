// To parse this JSON data, do
//
//     final senderResponseModel = senderResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:pailmail/models/senders/senders_1.dart';

SenderResponseModel_1 senderResponseModelFromJson(String str) =>
    SenderResponseModel_1.fromJson(json.decode(str));

String senderResponseModelToJson(SenderResponseModel_1 data) =>
    json.encode(data.toJson());

class SenderResponseModel_1 {
  Senders_1? senders;

  SenderResponseModel_1({this.senders});

  SenderResponseModel_1.fromJson(Map<String, dynamic> json) {
    senders =
        json['senders'] != null ? Senders_1.fromJson(json['senders']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.senders != null) {
      data['senders'] = this.senders!.toJson();
    }
    return data;
  }
}
