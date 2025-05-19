class senderMails {
  SenderMail? sender;

  senderMails({this.sender});

  senderMails.fromJson(Map<String, dynamic> json) {
    sender =
        json['sender'] != null ? new SenderMail.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    return data;
  }
}

class SenderMail {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  String? mailsCount;
  CategoryMail? category;
  List<Mails>? mails;

  SenderMail(
      {this.id,
      this.name,
      this.mobile,
      this.address,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.mailsCount,
      this.category,
      this.mails});

  SenderMail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mailsCount = json['mails_count'];
    category = json['category'] != null
        ? new CategoryMail.fromJson(json['category'])
        : null;
    if (json['mails'] != null) {
      mails = <Mails>[];
      json['mails'].forEach((v) {
        mails!.add(new Mails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mails_count'] = this.mailsCount;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.mails != null) {
      data['mails'] = this.mails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryMail {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CategoryMail({this.id, this.name, this.createdAt, this.updatedAt});

  CategoryMail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Mails {
  int? id;
  String? subject;
  String? description;
  String? senderId;
  String? archiveNumber;
  String? archiveDate;
  String? decision;
  String? statusId;
  String? finalDecision;
  String? createdAt;
  String? updatedAt;
  SenderMail? sender;
  Status? status;
  List<Attachments>? attachments;
  List<Activities>? activities;
  List<Tags>? tags;

  Mails(
      {this.id,
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
      this.tags});

  Mails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    description = json['description'];
    senderId = json['sender_id'];
    archiveNumber = json['archive_number'];
    archiveDate = json['archive_date'];
    decision = json['decision'];
    statusId = json['status_id'];
    finalDecision = json['final_decision'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender =
        json['sender'] != null ? new SenderMail.fromJson(json['sender']) : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['sender_id'] = this.senderId;
    data['archive_number'] = this.archiveNumber;
    data['archive_date'] = this.archiveDate;
    data['decision'] = this.decision;
    data['status_id'] = this.statusId;
    data['final_decision'] = this.finalDecision;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SenderMails {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  CategoryMail? category;

  SenderMails(
      {this.id,
      this.name,
      this.mobile,
      this.address,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.category});

  SenderMails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new CategoryMail.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class CategoryMails {
  int? id;
  String? name;

  CategoryMails({this.id, this.name});

  CategoryMails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Status {
  int? id;
  String? name;
  String? color;

  Status({this.id, this.name, this.color});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}

class Attachments {
  int? id;
  String? title;
  String? image;
  String? mailId;
  String? createdAt;
  String? updatedAt;

  Attachments(
      {this.id,
      this.title,
      this.image,
      this.mailId,
      this.createdAt,
      this.updatedAt});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    mailId = json['mail_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['mail_id'] = this.mailId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Activities {
  int? id;
  String? body;
  String? userId;
  String? mailId;
  String? sendNumber;
  String? sendDate;
  String? sendDestination;
  String? createdAt;
  String? updatedAt;
  User? user;

  Activities(
      {this.id,
      this.body,
      this.userId,
      this.mailId,
      this.sendNumber,
      this.sendDate,
      this.sendDestination,
      this.createdAt,
      this.updatedAt,
      this.user});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    userId = json['user_id'];
    mailId = json['mail_id'];
    sendNumber = json['send_number'];
    sendDate = json['send_date'];
    sendDestination = json['send_destination'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['user_id'] = this.userId;
    data['mail_id'] = this.mailId;
    data['send_number'] = this.sendNumber;
    data['send_date'] = this.sendDate;
    data['send_destination'] = this.sendDestination;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? emailVerifiedAt;
  String? roleId;
  String? createdAt;
  String? updatedAt;
  CategoryMail? role;

  User(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role =
        json['role'] != null ? new CategoryMail.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class Tags {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Tags({this.id, this.name, this.createdAt, this.updatedAt, this.pivot});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? mailId;
  String? tagId;

  Pivot({this.mailId, this.tagId});

  Pivot.fromJson(Map<String, dynamic> json) {
    mailId = json['mail_id'];
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail_id'] = this.mailId;
    data['tag_id'] = this.tagId;
    return data;
  }
}
