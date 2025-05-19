import 'package:pailmail/models/mails/mail_response_model.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';

class SearchRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<MailResponseModel> search(
      {required String text,
      DateTime? start,
      DateTime? end,
      String? status_id}) async {
    final response =
        await _helper.get("${searchUrl}text=$text&status_id=$status_id");
    print(searchUrl + "text=${text}&status_id=${status_id}");
    // print("*************$response");
    print('search done ');
    return MailResponseModel.fromJson(response);
    // final response = await _helper
    //     .get(searchUrl + "text=${text}&${start}&${end}&${status_id}");
  }
}
