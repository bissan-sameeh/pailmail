import 'package:pailmail/models/tags/tag.dart';
import 'package:flutter/cupertino.dart';

import '../core/helpers/api_helpers/api_response.dart';
import '../repositories/tag_repository.dart';

class TagProvider extends ChangeNotifier {
  String id = "135";
  List<String> list = ["38", "45", "27"];
  late TagRepository _repository;
  late ApiResponse<List<Tag>> _tagList;
  late ApiResponse<List<Tag>> _tagWithMailList;
  late ApiResponse<List<Tag>> _tagOfMailList;

 
  List<int> _tagIndex = [];


  ApiResponse<List<Tag>> get tagList => _tagList;
  List<int> get tagIndex => _tagIndex;

  ApiResponse<List<Tag>> get tagWithMailList => _tagWithMailList;

  ApiResponse<List<Tag>> get tagOMailList => _tagOfMailList;

  TagProvider() {
    _repository = TagRepository();
    getTagList();

    // getTagOfMailList(id);
    // getTagWithMailList(list);
  }
  changeSelectedTag({required List<int> selectedIndex}) {
    _tagIndex.addAll(selectedIndex);
    notifyListeners();
  }

  getTagList() async {
    _tagList = ApiResponse.loading("Fetching Tags");
    notifyListeners();
    try {
      List<Tag>? tags = await _repository
          .getTags(); // print("./////////.......${tags}......//////////////..........");

      _tagList = ApiResponse.completed(tags);
      notifyListeners();
    } catch (error) {
      _tagList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  getTagOfMailList(String id) async {
    _tagOfMailList = ApiResponse.loading("Fetching Tags");
    notifyListeners();
    try {
      List<Tag>? tags = await _repository.getTagsOfMail(
          id); //print("........${tags}......//////////////..........");

      _tagOfMailList = ApiResponse.completed(tags);
      notifyListeners();
    } catch (error) {
      _tagOfMailList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  getTagWithMailList(dynamic list) async {
    _tagWithMailList = ApiResponse.loading("Fetching Tags");
    notifyListeners();
    try {
      List<Tag>? tags = await _repository.getMailWithTags(list); // print(tags);

      _tagWithMailList = ApiResponse.completed(tags);
      notifyListeners();
    } catch (error) {
      _tagWithMailList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
