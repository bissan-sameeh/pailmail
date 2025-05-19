// import 'package:pailmail/models/roles/role.dart';
// import '../users/user.dart';
//
// class RoleResponseModel {
//   List<Roles>? roles;
//
//   RoleResponseModel({this.roles});
//
//   RoleResponseModel.fromJson(Map<String, dynamic> json) {
//     if (json['roles'] != null) {
//       roles = <Roles>[];
//       json['roles'].forEach((v) {
//         roles!.add(new Roles.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.roles != null) {
//       data['roles'] = this.roles!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Roles {
//   Role? role;
//   String? usersCount;
//   List<User>? users;
//
//   Roles({this.role, this.usersCount, this.users});
//
//   Roles.fromJson(Map<String, dynamic> json) {
//     usersCount = json['users_count'];
//     if (json['users'] != null) {
//       users = <User>[];
//       json['users'].forEach((v) {
//         users!.add(new User.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//
//     data['users_count'] = this.usersCount;
//     if (this.users != null) {
//       data['users'] = this.users!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
import 'package:pailmail/models/roles/role.dart';

class RoleResponseModel {
  List<Role>? roles;

  RoleResponseModel({
    this.roles,
  });
  RoleResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['roles'] != null) {
      roles = <Role>[];
      json['roles'].forEach((v) {
        roles!.add(Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
