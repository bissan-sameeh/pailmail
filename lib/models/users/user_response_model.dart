import 'package:pailmail/models/users/user.dart';

class UserResponseModel {
  late User user;
  late dynamic token;

  UserResponseModel({required this.user, required this.token});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null ? new User.fromJson(json['user']) : null)!;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user.toJson();
    data['token'] = this.token;
    return data;
  }
}
