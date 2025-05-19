import '../roles/role.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? emailVerifiedAt;
  String? roleId;
  String? createdAt;
  String? updatedAt;
  Role? role;

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
    role = json['role'] != null
        ?  Role.fromJson(json['role'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['email_verified_at'] = emailVerifiedAt;
    data['role_id'] = roleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (role != null) {
      data['role'] =role!.toJson();
    }
    return data;
  }
}
