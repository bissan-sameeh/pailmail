import 'package:pailmail/models/attachments/attachment.dart';

class AttachmentResponseModel {
  Attachment? attachment;

  AttachmentResponseModel({
    this.attachment,
  });


  factory AttachmentResponseModel.fromJson(Map<String, dynamic> json) => AttachmentResponseModel(
    attachment: json["attachment"] == null ? null : Attachment.fromJson(json["attachment"]),
  );

  Map<String, dynamic> toJson() => {
    "attachment": attachment?.toJson(),
  };

}


