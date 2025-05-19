
import 'package:flutter/material.dart';
import 'package:pailmail/models/senders/sender.dart';
import 'package:pailmail/repositories/categories_repositories/mail_catgory_repository.dart';

import '../../core/helpers/api_helpers/api_response.dart';

class CategoryMailProvider extends ChangeNotifier {
  late MailCategoryProvider _mailCategoryRepository;
   List<ApiResponse<List<Sender>?>> _mailsCategories = [];

  List<ApiResponse<List<Sender>?>> get mailsCategory => _mailsCategories;

  CategoryMailProvider() {
  _mailCategoryRepository = MailCategoryProvider();
  fetchCategoryMails(categoryId: "2", index: 0);
  fetchCategoryMails(categoryId: "3", index: 1);
  fetchCategoryMails(categoryId: "4", index: 2);
  fetchCategoryMails(categoryId: "1", index: 3);
  notifyListeners();
}
void fetchCategoryMails(
    {required String categoryId, required int index}) async {
  print("FFFFFFFFFFFFFFFF");
  if (_mailsCategories.length <= index) {
    _mailsCategories.add(ApiResponse.loading("Loading"));
  } else {
    _mailsCategories[index] = ApiResponse.loading("Loading");
  }
  notifyListeners();
  try {
    final response =
    await _mailCategoryRepository.fetchCategoryMails(categoryId: categoryId);
    _mailsCategories[index] = ApiResponse.completed(response);
    //print("rrrrrrrrrrrrrr" + _mailsCategories1[index].data![0].id.toString());
    notifyListeners();
  } catch (e) {
    _mailsCategories[index] = ApiResponse.error(e.toString());
    notifyListeners();
  }
}}