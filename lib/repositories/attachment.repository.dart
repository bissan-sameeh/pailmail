import 'dart:convert';
import 'dart:io';

import 'package:pailmail/models/attachments/attachment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/constants.dart';
import '../storage/shared_prefs.dart';
class AttachmentRepository{
Future<Attachment?> uploadAttachment(File? image,String mail_id,String title) async {
  final uri = Uri.parse(allAttachmentsUrl);

  var request = http.MultipartRequest('POST', uri)
    ..fields['mail_id'] = mail_id
    ..fields['title'] = title
    ..files.add(await http.MultipartFile.fromPath(
      'image', // اسم الحقل المتوقع من السيرفر
      image!.path,
    ));
  final token = SharedPreferencesController().token; // افترض أن عندك دالة تجيب التوكن من SharedPreferences مثلاً
  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Accept'] = 'application/json';
  final response = await request.send();
  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    print("successssssssssssssssssss");
    return Attachment.fromJson(jsonDecode(responseBody));
  } else {
    print('فشل الرفع: ${response.statusCode}');
    return null;
  }
}


}
