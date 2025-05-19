// To parse this JSON data, do
//
//     final mailResponseModel = mailResponseModelFromJson(jsonString);

import 'dart:convert';

import 'mail.dart';

MailResponseModel mailResponseModelFromJson(String str) =>
    MailResponseModel.fromJson(json.decode(str));

String mailResponseModelToJson(MailResponseModel data) =>
    json.encode(data.toJson());

class MailResponseModel {
  List<Mail>? mails;

  MailResponseModel({
    this.mails,
  });

  factory MailResponseModel.fromJson(Map<String, dynamic> json) =>
      MailResponseModel(
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
      };
}

// class Sender {
//   int? id;
//   String? name;
//   String? mobile;
//   String? address;
//   String? categoryId;
//   String? createdAt;
//   String? updatedAt;
//   Tag? category; ////datatype is tag here not category
//
//   Sender({
//     this.id,
//     this.name,
//     this.mobile,
//     this.address,
//     this.categoryId,
//     this.createdAt,
//     this.updatedAt,
//     this.category,
//   });
//
//   factory Sender.fromJson(Map<String, dynamic> json) => Sender(
//         id: json["id"],
//         name: json["name"],
//         mobile: json["mobile"],
//         address: json["address"],
//         categoryId: json["category_id"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         category:
//             json["category"] == null ? null : Tag.fromJson(json["category"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "mobile": mobile,
//         "address": address,
//         "category_id": categoryId,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "category": category?.toJson(),
//       };
// }
