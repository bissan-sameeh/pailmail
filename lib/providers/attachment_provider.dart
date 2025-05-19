import 'dart:io';

import 'package:pailmail/models/attachments/attachment.dart';
import 'package:pailmail/repositories/attachment.repository.dart';
import 'package:flutter/material.dart';

import '../core/helpers/api_helpers/api_response.dart';

class AttachmentProvider extends ChangeNotifier {
  late AttachmentRepository _attachmentRepository;

  late ApiResponse<Attachment> _attachment;
   ApiResponse<Attachment> get attachment=> _attachment;


  AttachmentProvider() {
    _attachmentRepository = AttachmentRepository();
  }

  uploadAttachment(File? image,String mail_id,String title) async {
    _attachment = ApiResponse.loading('Fetching current user');
    notifyListeners();
    try {
      print('u upload image right now !');
      print("image info $title , $mail_id , $image");

      var response = await _attachmentRepository.uploadAttachment(image, mail_id, title);

      _attachment = ApiResponse.completed(response);
      print("res $response");
      print('uploaded image');
      notifyListeners();
    } catch (e) {
      _attachment = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }



}