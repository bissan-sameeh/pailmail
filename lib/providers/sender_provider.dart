import 'package:pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:pailmail/models/mails/mail.dart';
import 'package:pailmail/models/senders/sender.dart';
import 'package:pailmail/models/senders/senderMails.dart';
import 'package:pailmail/repositories/sender_repository.dart';
import 'package:flutter/cupertino.dart';

import '../models/senders/senders_1.dart';

class SenderProvider extends ChangeNotifier {
  late SenderRepository _repository;
  late ApiResponse<List<Data>> _senderList;
  late ApiResponse<List<Mails>> _mailOfSenderList;

  ApiResponse<List<Data>> get senderList => _senderList;

  ApiResponse<List<Mails>> get mailOfSenderList => _mailOfSenderList;
  late String id;

  SenderProvider() {
    _repository = SenderRepository();
    getSenderList();
  }

  getSenderList() async {
    _senderList = ApiResponse.loading("Fetching Senders");
    notifyListeners();
    try {
      List<Data>? senders = await _repository.getallSender();
      _senderList = ApiResponse.completed(senders);
      notifyListeners();
    } catch (error) {
      _senderList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  Future<void> getMailsOfSenderList({required String id}) async {
    _mailOfSenderList = ApiResponse.loading("Fetching Mails of Senders");
    notifyListeners();
    try {
      final senders = await _repository.getAllMailToSender(id);
      _mailOfSenderList = ApiResponse.completed(senders);
      notifyListeners();
    } catch (error) {
      _mailOfSenderList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
