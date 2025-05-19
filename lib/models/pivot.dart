class Pivot {
  String? mailId;
  String? tagId;

  Pivot({
    this.mailId,
    this.tagId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        mailId: json["mail_id"],
        tagId: json["tag_id"],
      );

  Map<String, dynamic> toJson() => {
        "mail_id": mailId,
        "tag_id": tagId,
      };
}
