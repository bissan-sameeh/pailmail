import 'package:pailmail/models/users/user_response_model.dart';
import 'package:pailmail/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import '../core/helpers/api_helpers/api_response.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository _authRepository;

  late ApiResponse<UserResponseModel> _current;

  ApiResponse<UserResponseModel> get currentUser => _current;

  AuthProvider() {
    _authRepository = AuthRepository();
    fetchCurrentUser();
  }

  fetchCurrentUser() async {
    _current = ApiResponse.loading('Fetching current user');
    notifyListeners();
    try {
      UserResponseModel user = await _authRepository.fetchCurrentUser();

      _current = ApiResponse.completed(user);
      print('current user');
      // print(_current.data?.token);
      // print(_current.data?.user.id);

      notifyListeners();
    } catch (e) {
      _current = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  logout() async {
    print('logout user');
    notifyListeners();
    try {
      await _authRepository.LogoutUser();
      print('logout ');
      // print(_current.data?.token);
      // print(_current.data?.user.id);

      notifyListeners();
    } catch (e) {
      _current = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

// //update profile
//   updateCurrentUser({
//     required String name,
//   }) async {
//     _current = ApiResponse.loading('updating current user');
//     notifyListeners();
//     try {
//       UserResponseModel updatedUser = await _authRepository.updateCurrentUser(
//         name: name,
//       );
//       print('provider : $updatedUser');
//
//       _current = ApiResponse.completed(updatedUser);
//       // set locally
//       SharedPrefrencesController().setData(PrefKeys.name.toString(), name);
//       print('updated  user');
//       print(_current.data!.user.name);
//       // print(_current.data?.user.id);
//
//       notifyListeners();
//     } catch (e) {
//       _current = ApiResponse.error(e.toString());
//       notifyListeners();
//     }
//   }
}
