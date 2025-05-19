import '../mails/mail.dart';
import '../pivot.dart';

class Tag {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Mail>? mails;
  Pivot? pivot;

  Tag({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.mails,
    this.pivot,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
        "pivot": pivot?.toJson(),
      };
}
