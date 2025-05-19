import 'package:pailmail/core/helpers/api_helpers/api_base_helper.dart';
import 'package:pailmail/core/utils/constants.dart';
import 'package:pailmail/models/senders/sender.dart';

import '../../models/categories/category_base_response.dart';
import '../../models/categories/category_response_model.dart';



class CategoryRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<CategoryElement>?> fetchCategories() async {
    print("start ca");
    final allCategoriesResponse = await _helper.get(allCategoriesUrl);
    print("lllllllllllllllllll $allCategoriesResponse");
    final categories = CategoryResponseModel.fromJson(allCategoriesResponse).categories;
    print("oooooooooooooooooooooooooo $categories");
    return categories;
  }

  //TODO:Use this response :)
  Future<CategoryElement> getSingleCategory(
      {required String categoryId}) async {
    final singleCategoryResponse =
        await _helper.get("$categoryMailUrl$categoryId");
    //   print(singleCategoryResponse['category']);
    return CategoryElement.fromJson(singleCategoryResponse['category']);
  }

  Future<void> createCategory({required String categoryName}) async {
    Map<String, String> body = {'name': categoryName};
    final createCategoryResponse = await _helper.post(allCategoriesUrl, body);
    //TODO: Complete the response handling
  }


}
