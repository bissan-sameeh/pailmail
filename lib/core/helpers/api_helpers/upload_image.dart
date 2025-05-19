import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../storage/shared_prefs.dart';
import '../../utils/constants.dart';

class UploadImage {
  Future<int> uploadImage(File file, mailId) async {
    var request =
        http.MultipartRequest("POST", Uri.parse('$baseUrl/attachments'));
//create multipart using filepath, string or bytes .
    var pic = await http.MultipartFile.fromPath('image', file.path);
    request.fields['mail_id'] = mailId.toString();
    request.fields['title'] = 'image_${DateTime.now()}';
//add multipart to request
    request.files.add(pic);
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPreferencesController().token}'
    });
    var response = await request.send();

//Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    return response.statusCode;
  }
}
