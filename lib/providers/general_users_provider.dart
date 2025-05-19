import 'package:flutter/material.dart';

import '../core/helpers/api_helpers/api_response.dart';
import '../models/users/user.dart';
import '../repositories/general_users_repository.dart';

class GeneralUsersProvider extends ChangeNotifier {
  late GeneralUsersRepository _generalUsersRepository;

  late ApiResponse<List<User>> _generalUsersList;

  ApiResponse<List<User>> get generalUsersList => _generalUsersList;

  GeneralUsersProvider() {
    _generalUsersRepository = GeneralUsersRepository();
    fetchGeneralUsersList();
  }

  fetchGeneralUsersList() async {
    _generalUsersList = ApiResponse.loading('Fetching General Users');
    notifyListeners();
    try {
      List<User>? usersList =
          await _generalUsersRepository.fetchGeneralUsersList();
      if (usersList != null) {
        _generalUsersList = ApiResponse.completed(usersList);
      }
      notifyListeners();
    } catch (e) {
      _generalUsersList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
