import 'package:easy_localization/easy_localization.dart';
import 'package:pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:pailmail/main.dart';
import 'package:pailmail/models/categories/category_response_model.dart';
import 'package:pailmail/models/mails/mail.dart';
import 'package:pailmail/repositories/categories_repositories/categories_repositry.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  late ApiResponse<List<CategoryElement>> _allCategories;
  int _index = 0;
  int _senderIndex = -1; //there is nothing element selected..
  int _categoryIndex = 1;

  List<ApiResponse<List<Mail>>> _mailsCategories = [];
  late CategoryRepository _categoryRepository;

  CategoriesProvider() {
    _categoryRepository = CategoryRepository();
    fetchAllCategories();

  }

  ApiResponse<List<CategoryElement>> get allCategories => _allCategories;

  List<ApiResponse<List<Mail>>> get mailsCategory => _mailsCategories;

  int get selectedIndex => _index;
  int get categoryPosition => _categoryIndex;

  int get senderPosition => _senderIndex;

  String get senderNameHint {
    if (categoryPosition == -1 ||
        senderPosition == -1 ||
        allCategories.data == null ||
        categoryPosition >= allCategories.data!.length ||
        senderPosition >= allCategories.data![categoryPosition].senders!.length) {
      return "sender name".tr();
    }

    return allCategories.data![categoryPosition].senders![senderPosition].name !;
  }

  Sender? get selectedSender {
    if (categoryPosition == -1 ||
        senderPosition == -1 ||
        allCategories.data == null ||
        categoryPosition >= allCategories.data!.length ||
        senderPosition >= allCategories.data![categoryPosition].senders!.length) {
      return null;
    }

    return allCategories.data![categoryPosition].senders![senderPosition];
  }
  String get senderMobileHint {
    if (senderPosition == -1 || categoryPosition == -1) {
      return "mobile number".tr();
    }

    try {
      final category = allCategories.data?[categoryPosition];
      final sender = category?.senders?[senderPosition];
      return sender?.mobile ?? "mobile number".tr();
    } catch (e) {
      return "mobile number".tr();
    }
  }

  void fetchAllCategories() async {
    _allCategories = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      print("all cat");
      final response = await _categoryRepository.fetchCategories();
      _allCategories = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _allCategories = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }


//to change category



  setCategoryIndex(   { required int categoryIndex}){
    _categoryIndex = categoryIndex;
    notifyListeners();

  }

  setSenderIndex({required int selectedIndex}){
    _senderIndex = selectedIndex;
    notifyListeners();
  }
// void fetchCategory1Mails({required String categoryId}) async {
//   _mailsCategories1 = ApiResponse.loading("Loading");
//   notifyListeners();
//   try {
//     final response =
//         await _categoryRepository.fetchCategoryMails(categoryId: categoryId);
//     _mailsCategories1 = ApiResponse.completed(response);
//     //print("rrrrrrrrrrrrrr" + _mailsCategories1[index].data![0].id.toString());
//     notifyListeners();
//   } catch (e) {
//     _mailsCategories1 = ApiResponse.error(e.toString());
//     notifyListeners();
//   }
// }
//
// void fetchCategory2Mails({required String categoryId}) async {
//   _mailsCategories2 = ApiResponse.loading("Loading");
//   notifyListeners();
//   try {
//     final response =
//         await _categoryRepository.fetchCategoryMails(categoryId: categoryId);
//     _mailsCategories2 = ApiResponse.completed(response);
//     //print("rrrrrrrrrrrrrr" + _mailsCategories1[index].data![0].id.toString());
//     notifyListeners();
//   } catch (e) {
//     _mailsCategories2 = ApiResponse.error(e.toString());
//     notifyListeners();
//   }
// }
//
// void fetchCategory3Mails({required String categoryId}) async {
//   _mailsCategories3 = ApiResponse.loading("Loading");
//   notifyListeners();
//   try {
//     final response =
//         await _categoryRepository.fetchCategoryMails(categoryId: categoryId);
//     _mailsCategories3 = ApiResponse.completed(response);
//     //print("rrrrrrrrrrrrrr" + _mailsCategories1[index].data![0].id.toString());
//     notifyListeners();
//   } catch (e) {
//     _mailsCategories3 = ApiResponse.error(e.toString());
//     notifyListeners();
//   }
// }
//
// void fetchCategory4Mails({
//   required String categoryId,
// }) async {
//   _mailsCategories4 = ApiResponse.loading("Loading");
//   notifyListeners();
//   try {
//     final response =
//         await _categoryRepository.fetchCategoryMails(categoryId: categoryId);
//     _mailsCategories4 = ApiResponse.completed(response);
//     //print("rrrrrrrrrrrrrr" + _mailsCategories1[index].data![0].id.toString());
//     notifyListeners();
//   } catch (e) {
//     _mailsCategories4 = ApiResponse.error(e.toString());
//     notifyListeners();
//   }
// }
}
