import 'package:pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:pailmail/repositories/mails_reprository.dart';
import 'package:flutter/cupertino.dart';

import '../models/mails/activity.dart';
import '../models/mails/mail.dart';

class MailProvider extends ChangeNotifier {
  late MailsRepository _mailsRepository;
  late ApiResponse<List<Mail>> _mailsList;
  late ApiResponse<List<Mail>> _singleMail;
  late ApiResponse<List<Activity>> _activityMail;

  // late SearchRepository _searchRepository;

  ///to view a list of all mails
  MailProvider() {
    _mailsRepository = MailsRepository();
    //_searchRepository = SearchRepository();
    fetchAllMails();
    // fetchSingleMail("146");
    // fetchActivityMail("315");
  }

  ApiResponse<List<Mail>> get mails => _mailsList;
  ApiResponse<List<Mail>> get singleMail => _singleMail;
  ApiResponse<List<Activity>> get activityMail => _activityMail;

  Future<void> fetchAllMails() async {
    _mailsList = ApiResponse.loading("loading");
    notifyListeners();
    try {
      final response = await _mailsRepository.fetchAllMails();
      _mailsList = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _mailsList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> fetchActivityMail(String id) async {
    _activityMail = ApiResponse.loading("loading");
    notifyListeners();
    try {
      List<Activity>? response = await _mailsRepository.fetchActivities(
          id: id); //add id here as string
      _activityMail = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _activityMail = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> fetchSingleMail(String id) async {
    _singleMail = ApiResponse.loading("loading");
    notifyListeners();
    try {
      final response = await _mailsRepository.fetchSingleMail(
          id: id); //add id here as string
      _singleMail = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _singleMail = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  // Future<MailResponseModel> searchMails(String text) async {
  //   _mailsList = ApiResponse.loading("loading");
  //   notifyListeners();
  //   try {
  //     final response =
  //         await _searchRepository.search(text: text);
  //    return ApiResponse.completed(response);
  //     notifyListeners();
  //   } catch (e) {
  //     _mailsList = ApiResponse.error(e.toString());
  //     notifyListeners();
  //   }
  // }
  // Future<void> createEmail(
  //     {required String subject,
  //     String? description,
  //     required int sender_id,
  //     required String archive_number,
  //     required DateTime archive_date,
  //     String? decision,
  //     required int status_id,
  //     String? final_decision,
  //     List<int>? tags,
  //     List<Map<String, dynamic>>? activities}) async {
  //   _singleMail = ApiResponse.loading("loading");
  //   notifyListeners();
  //   try {
  //     final response = await _mailsRepository.createMail(
  //         subject: subject,
  //         decision: decision,
  //         final_decision: final_decision,
  //         description: description,
  //         tags: tags,
  //         sender_id: sender_id,
  //         archive_number: archive_number,
  //         archive_date: archive_date,
  //         status_id: status_id);
  //     _singleMail = ApiResponse.completed(response);
  //     print("ooooooooo");
  //     notifyListeners();
  //   } catch (e) {
  //     _singleMail = ApiResponse.error(e.toString());
  //     notifyListeners();
  //   }
  // }

  // Future<void> updateEmail(
  //     {required String id,
  //     String? decision,
  //     required int status_id,
  //     String? final_decision,
  //     List<int>? tags,
  //     List<int>? idAttachmentsForDelete,
  //     List<int>? pathAttachmentsForDelete,
  //     List<Map<String, dynamic>>? activities}) async {
  //   _singleMail = ApiResponse.loading("loading");
  //   notifyListeners();
  //   try {
  //     final response = await _mailsRepository.updateMail(
  //         id: id,
  //         status_id: status_id,
  //         final_decision: final_decision,
  //         decision: decision,
  //         tags: tags,
  //         idAttachmentsForDelete: idAttachmentsForDelete,
  //         pathAttachmentsForDelete: pathAttachmentsForDelete);
  //     _singleMail = ApiResponse.completed(response);
  //
  //     notifyListeners();
  //   } catch (e) {
  //     _singleMail = ApiResponse.error(e.toString());
  //     notifyListeners();
  //   }
  // }
  //
  // Future<void> deleteEmail({required String id}) async {
  //   _del = ApiResponse.loading("loading");
  //   try {
  //     final response = await _mailsRepository.deleteMail(id: id);
  //     _del = ApiResponse.completed(response);
  //     notifyListeners();
  //   } catch (e) {
  //     _del = ApiResponse.error(e.toString());
  //     notifyListeners();
  //   }
  // }
}
