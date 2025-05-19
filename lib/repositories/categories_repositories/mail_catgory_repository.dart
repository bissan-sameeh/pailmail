import '../../core/helpers/api_helpers/api_base_helper.dart';
import '../../core/utils/constants.dart';
import '../../models/categories/category_base_response.dart';
import '../../models/senders/sender.dart';

class MailCategoryProvider {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Sender>?> fetchCategoryMails({required String categoryId}) async {
    // print("**************mails}");
    print("**************$categoryMailUrl$categoryId/mails");
    print('pppppppppppppppppppppppppppppppppppppppppppp');
    final categoryMailsResponse =
    await _helper.get("$categoryMailUrl$categoryId/mails");
    print("uuuuuuuuuuuuuuuuuu$categoryMailsResponse");

    print("*************categoryMailsResponse${CategoryBaseResponse.fromJson(categoryMailsResponse)}");
    return CategoryBaseResponse.fromJson(categoryMailsResponse).category?.senders;
  }
}