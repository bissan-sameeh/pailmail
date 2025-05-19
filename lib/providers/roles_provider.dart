import 'package:flutter/material.dart';

import '../core/helpers/api_helpers/api_response.dart';
import '../models/roles/role.dart';
import '../repositories/roles_repository.dart';

class RoleProvider extends ChangeNotifier {
  late RoleRepository _roleRepository;

  late ApiResponse<List<Role>> _roleList;

  ApiResponse<List<Role>> get roleList => _roleList;

  RoleProvider() {
    _roleRepository = RoleRepository();
    fetchRoleList();
  }

  fetchRoleList() async {
    _roleList = ApiResponse.loading('Fetching roles');
    notifyListeners();
    try {
      List<Role>? roles = await _roleRepository.fetchRoleList();
      if (roles != null) {
        _roleList = ApiResponse.completed(roles);
        print('rolelist');
        print(_roleList.data?[0].name);
      }
      notifyListeners();
    } catch (e) {
      _roleList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
