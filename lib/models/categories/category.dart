import '../pivot.dart';
import '../senders/sender.dart';

class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
   String? sendersCount;
   List<Sender>? senders;



  Category({
    this.id,
    this.name,
     this.sendersCount,

    this.createdAt,
    this.updatedAt,
    this.pivot,
     this.senders,

  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    sendersCount: json["senders_count"]!=null ? json["senders_count"]:null,
    senders: json["senders"] != null
        ? List<Sender>.from(json["senders"].map((x) => Sender.fromJson(x)))
        : null,
    pivot: json["pivot"] != null ? Pivot.fromJson(json["pivot"]) : null,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot?.toJson(),
      };
}
