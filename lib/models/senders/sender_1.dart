import '../categories/category.dart';
import '../mails/mail.dart';

class Sender_1 {
  Sender1 sender;
  Sender_1({
    required this.sender,
  });
}

class Sender1 {
  int? id;
  String? name;
  String? mobile;
  dynamic? address;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  String? mailsCount;
  Category? category;
  List<Mail>? mails;

  Sender1({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.mailsCount,
    this.category,
    this.mails,
  });

  factory Sender1.fromJson(Map<String, dynamic> json) => Sender1(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        mailsCount: json["mails_count"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "mails_count": mailsCount,
        "category": category?.toJson(),
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
      };
}
