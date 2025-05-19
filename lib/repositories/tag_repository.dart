
import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';
import '../models/tags/tag.dart';
import '../models/tags/tag_response_model.dart';
import '../models/tags/tags_of_mail.dart';
import '../models/tags/tags_with_mails.dart';

class TagRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<int> createTag(String tag) async {
    Map<String, String> map = {
      "name": tag,
    };
    final response = await _helper.post(allTagsUrl, map);

    return response['tag']["id"];
  }

  Future<List<Tag>?> getTags() async {
    final response = await _helper.get(allTagsUrl);

    return TagResponseModel.fromJson(response).tags;
  }

  //{{baseUrl}}/mails/{id}/tags
  Future<List<Tag>?> getTagsOfMail(String id) async {
    final response = await _helper.get("$CRUD_mailsUrl$id/tags");

    return TagsOfMail.fromJson(response).tags;
  }

  Future<List<Tag>?> getMailWithTags(dynamic list) async {
    final response = await _helper.get("$allTagsUrl?tags=$list");
    return TagsWithMails.fromJson(response).tags;
  }
}
