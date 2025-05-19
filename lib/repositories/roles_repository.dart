import 'package:pailmail/models/roles/role_response_model.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';
import '../models/roles/role.dart';

class RoleRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Role>?> fetchRoleList() async {
    print('role repo');
    final response = await _helper.get(allRolesUrl);
    return RoleResponseModel.fromJson(response).roles;
  }
}
