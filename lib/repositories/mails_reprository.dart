import 'dart:convert';

import 'package:pailmail/core/helpers/api_helpers/api_base_helper.dart';
import 'package:pailmail/models/mails/activity.dart';

import '../core/utils/constants.dart';
import '../models/mails/mail.dart';
import '../models/mails/mail_response_model.dart';

class MailsRepository {
  final ApiBaseHelper _hepler = ApiBaseHelper();

  Future<List<Mail>?> fetchAllMails() async {
    final response = await _hepler.get(allMailsUrl);
    return MailResponseModel.fromJson(response).mails;
  }

  Future<List<Mail>?> fetchSingleMail({required String id}) async {
    final response = await _hepler.get(CRUD_mailsUrl + id);
    print(response);
    return MailResponseModel.fromJson(response).mails;
  }

  Future<Mail?> createMail(
      {required String subject,
      String? description,

      required String sender_id,
      required String archive_number,
      required DateTime archive_date,
      String? decision,

      required String status_id,
      String? final_decision,
      List<int>? tags,

        List<String>? images,
      List<Map<String, dynamic>>? activities}) async {
    print("create new mail besoooooooooooooo");
    final Map<String, String> body = {
      "subject": subject.toString(),
      "description": description.toString(),
      "sender_id": sender_id.toString(),
      "archive_number": archive_number,
      "archive_date": archive_date.toString(),
      "decision": decision.toString(),
      "status_id": status_id.toString(),
      "final_decision": final_decision.toString(),
      "tags": jsonEncode(tags),
      "activities": jsonEncode(activities)
    };
    // print(body);
    final response = await _hepler.post(allMailsUrl, body);
    print("create mail");
    print('🧪 Raw mail map: ${response['mail']}');
    final mail = Mail.fromJson(response['mail']);
    print(" rrrrrrrrrr $mail");
    return mail;
  }

  Future<List<Activity>?> fetchActivities({required String id}) async {
    final response = await _hepler.get(CRUD_mailsUrl + id);
    print(response);
    print("${Mail.fromJson(response['mail']).activities}");
    return Mail.fromJson(response['mail']).activities;
  }

  // Future<Attachment?> uploadAttachment(File? image,String mail_id,String title) async {
  //   final uri = Uri.parse(allAttachmentsUrl);
  //
  //   var request = http.MultipartRequest('POST', uri)
  //     ..fields['mail_id'] = mail_id
  //     ..fields['title'] = title
  //     ..files.add(await http.MultipartFile.fromPath(
  //       'image', // اسم الحقل المتوقع من السيرفر
  //       image!.path,
  //     ));
  //   final response = await request.send();
  //   if (response.statusCode == 200) {
  //     final responseBody = await response.stream.bytesToString();
  //     return Attachment.fromJson(jsonDecode(responseBody));
  //   } else {
  //     print('فشل الرفع: ${response.statusCode}');
  //     return null;
  //   }
  // }


  Future<Mail?> updateMail(
      {required String id,
      String? decision,
      required int status_id,
      String? final_decision,
      List<int>? tags,
      List<int>? idAttachmentsForDelete,
      List<int>? pathAttachmentsForDelete,
      List<Map<String, dynamic>>? activities}) async {
    final Map<String, String> body = {
      "decision": decision.toString(),
      "status_id": status_id.toString(),
      "final_decision": final_decision.toString(),
      "tags": jsonEncode(tags),
      "activities": jsonEncode(activities),
      "idAttachmentsForDelete": jsonEncode(idAttachmentsForDelete),
      "pathAttachmentsForDelete": jsonEncode(pathAttachmentsForDelete)
    };
    print("jjjjjjjjjjj");
    final response = await _hepler.put(CRUD_mailsUrl + id, body);
    return Mail.fromJson(response['mail']);
  }

  Future<bool> deleteMail({required String id}) async {
    final response = await _hepler.delete(allMailsUrl + id);
    return response;
  }
}
