import 'package:pailmail/models/mails/mail.dart';

import '../pivot.dart';

class Status {
  int? id;
  String? name;
  String? color;
  Pivot? pivot;
  String? createdAt;
  String? updatedAt;
  String? mailsCount;
  List<Mail>? mails;
  Status(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.color,
      this.pivot,
      this.mailsCount,
      this.mails});

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        color: json["color"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        mailsCount: json["mails_count"],
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
        //     if (json['mails'] != null) {
        // mails = <Mails>[];
        // json['mails'].forEach((v) {
        // mails!.add(new Mails.fromJson(v));
        // });
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "color": color,
        "pivot": pivot?.toJson(),
        "mails_count": mailsCount,
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
      };
}
