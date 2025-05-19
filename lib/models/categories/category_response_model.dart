// To parse this JSON data, do
//
//     final categoryResponseModel = categoryResponseModelFromJson(jsonString);

import 'dart:convert';


CategoryResponseModel categoryResponseModelFromJson(String str) => CategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(CategoryResponseModel data) => json.encode(data.toJson());

class CategoryResponseModel {
  List<CategoryElement>? categories;

  CategoryResponseModel({
    this.categories,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
    categories: json["categories"] == null ? [] : List<CategoryElement>.from(json["categories"]!.map((x) => CategoryElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class CategoryElement {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic sendersCount;
  List<Sender>? senders;

  CategoryElement({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.sendersCount,
    this.senders,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    sendersCount: json["senders_count"],
    senders: json["senders"] == null ? [] : List<Sender>.from(json["senders"]!.map((x) => Sender.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "senders_count": sendersCount,
    "senders": senders == null ? [] : List<dynamic>.from(senders!.map((x) => x.toJson())),
  };
}

class Sender {
  int? id;
  String? name;
  String? mobile;
  dynamic address;
  dynamic categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Sender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    address: json["address"],
    categoryId: json["category_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "address": address,
    "category_id": categoryId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
