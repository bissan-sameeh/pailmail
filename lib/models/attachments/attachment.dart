class Attachment {
  String? title;
  String? image;
  String? mailId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Attachment({
    this.title,
    this.image,
    this.mailId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        title: json["title"],
        image: json["image"],
        mailId: json["mail_id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "mail_id": mailId,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
