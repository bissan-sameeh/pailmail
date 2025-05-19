
import '../attachments/attachment.dart';
import '../senders/sender.dart';
import '../statuses/status.dart';
import '../tags/tag.dart';
import 'activity.dart';

class Mail {
   int? id;
   String? subject;
   String? description;
   String? senderId;
   String? archiveNumber;
   String? archiveDate;

   String? statusId;
   String? decision;
   String? finalDecision;
   String? createdAt;
   String? updatedAt;
   Sender? sender;
   Status? status;
   List<Attachment>? attachments;
   List<Activity>? activities;
   List<Tag>? tags;

  Mail({
    this.id,
    this.subject,
    this.description,
    this.senderId,
    this.archiveNumber,
    this.archiveDate,
    this.decision,
    this.statusId,
    this.finalDecision,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.status,
    this.attachments,
    this.activities,
    this.tags,
  });

  factory Mail.fromJson(Map<String, dynamic> json) => Mail(
        id: json["id"],
        subject: json["subject"],
        description: json["description"],
        senderId: json["sender_id"],
        archiveNumber: json["archive_number"],
        archiveDate: json["archive_date"],
        decision: json["decision"],
        statusId: json["status_id"],
        finalDecision: json["final_decision"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        activities: json["activities"] == null
            ? []
            : List<Activity>.from(
                json["activities"]!.map((x) => Activity.fromJson(x))),
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "description": description,
        "sender_id": senderId,
        "archive_number": archiveNumber,
        "archive_date": archiveDate,
        "decision": decision,
        "status_id": statusId,
        "final_decision": finalDecision,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "sender": sender?.toJson(),
        "status": status?.toJson(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "activities": activities == null
            ? []
            : List<dynamic>.from(activities!.map((x) => x.toJson())),
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}
