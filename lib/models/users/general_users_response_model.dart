import 'package:pailmail/models/users/user.dart';

class GeneralUserModelResponse {
  List<User>? users;

  GeneralUserModelResponse({this.users});

  GeneralUserModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
