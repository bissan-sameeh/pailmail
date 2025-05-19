import 'package:pailmail/core/helpers/api_helpers/api_base_helper.dart';
import 'package:pailmail/models/statuses/status.dart';

import '../core/utils/constants.dart';
import '../models/statuses/status_reponse_model.dart';

class StatusRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  Future<List<Status>?> getAllStatus() async {
    final response = await _helper.get("$fetchUrl?mail=false");
    return StatusResponseModel.fromJson(response).statuses;
  }

  Future<Status>? getSingleStatus({required String id}) async {
    final response = await _helper.get("$fetchUrl$id?mail=true");
    print("*************${response}");
    return Status.fromJson(response["status"]);
  }
}
