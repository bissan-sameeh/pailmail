import 'dart:io';

import 'package:pailmail/core/utils/constants.dart';
import 'package:pailmail/models/users/user_response_model.dart';
import 'package:pailmail/storage/shared_prefs.dart';
import 'package:http/http.dart' as http;

import '../core/helpers/api_helpers/api_base_helper.dart';

class AuthRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final SharedPreferencesController prefs = SharedPreferencesController();

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final loginResponse = await _helper.post(loginUrl, body);
    UserResponseModel userResponseModel =
        UserResponseModel.fromJson(loginResponse);

    print('نيممممممممممممممم:${userResponseModel.user.name}');

    print('${userResponseModel.user.role?.id}');

    await SharedPreferencesController().saveAuth(
        userModel: UserResponseModel(
          user: userResponseModel.user,
          token: userResponseModel.token,
        ),
        isLogin: false);

    return userResponseModel;
  }

  Future<dynamic> register({
    required String email,
    required String password,
    required String password_confirmation,
    required String name,
  }) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'name': name
    };

    final registerResponse = await _helper.post(registerUrl, body);
    UserResponseModel userResponseModel =
        UserResponseModel.fromJson(registerResponse);
    //save locally
    await SharedPreferencesController().saveAuth(
        userModel: UserResponseModel(
            user: userResponseModel.user, token: userResponseModel.token),
        isLogin: true);
    print(SharedPreferencesController().name);

    return UserResponseModel.fromJson(registerResponse);
  }

  Future<dynamic> fetchCurrentUser() async {
    final currentUserResponse = await _helper.get(currentUserInfoUrl);
    print('fetchCurrentUser');
    print(currentUserResponse);
    return UserResponseModel.fromJson(currentUserResponse);
  }

/***********************************/ ////
  ////****  update  *****/////
  Future<dynamic> updateCurrentUser({
    required String name,
    String? image,
  }) async {
    Map<String, String> body = {
      'name': name,
      // 'image': image,
    };
    print('upddatetUser');
    print(currentUpdateUserUrl);

    final upddatetUserResponse = await _helper.post(currentUpdateUserUrl, body);
    print('update/::::::$upddatetUserResponse');

    // set locally
    SharedPreferencesController().setData(PrefKeys.name.toString(), name);
    SharedPreferencesController().setData(PrefKeys.image.toString(), image);
    print(
        '${SharedPreferencesController().setData(PrefKeys.name.toString(), name)}');

    print('updateCurrentUser authrepo');
    return UserResponseModel.fromJson(upddatetUserResponse);
  }

  Future<dynamic> LogoutUser() async {
    final logoutResponse = await _helper.postDel(logoutrUrl);
    // await SharedPrefrencesController().clear();
    return UserResponseModel.fromJson(logoutResponse);
  }

  Future<int> uploadImage(File file, userName) async {
    var request =
        http.MultipartRequest("POST", Uri.parse('$baseUrl/user/update'));

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath('image', file.path);
    // request.fields['mail_id'] = mailId.toString();
    request.fields['name'] = userName;

    ///add username

    //add multipart to request
    request.files.add(pic);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPreferencesController().token}'
    });
    var response = await request.send();

//Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    return response.statusCode;
  }
// Future<void> uploadProfileImage(File imageFile) async {
//   var request =
//       http.MultipartRequest("POST", Uri.parse('$baseUrl/user/update'));
//   var newImage = await http.MultipartFile.fromPath('image', imageFile.path);
//   request.fields['title'] = 'image_${DateTime.now()}';
//   request.files.add(newImage);
//   request.headers.addAll({
//     'Accept': 'application/json',
//     'Authorization': 'Bearer ${SharedPrefrencesController().token}'
//   });
//   var response = await request.send();
//   var responseStream = await response.stream.toBytes();
//   var responseString = String.fromCharCodes(responseStream);
//
//   print(responseString);
//   print('uploadProfileImage auth repo');
// }
//
// Future<String?> getNewProfilePic() async {
//   print('getNewProfilePic auth repo');
//
//   final imageResponse = await _helper.get((currentUserInfoUrl));
//   return UserResponseModel.fromJson(imageResponse).user.image;
// }
}
