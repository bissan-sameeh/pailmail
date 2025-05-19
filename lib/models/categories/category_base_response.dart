import 'package:pailmail/models/categories/category.dart';

class CategoryBaseResponse {
  Category? category;

  CategoryBaseResponse({
    this.category,
  });


  factory CategoryBaseResponse.fromJson(Map<String, dynamic> json) => CategoryBaseResponse(
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );



}