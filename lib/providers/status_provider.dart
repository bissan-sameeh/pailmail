import 'package:flutter/cupertino.dart';

import '../core/helpers/api_helpers/api_response.dart';
import '../models/statuses/status.dart';
import '../repositories/status_reprository.dart';

class StatusProvider extends ChangeNotifier {
  late StatusRepository _statusRepository;
  late ApiResponse<List<Status>> _statusList;
  late ApiResponse<Status> _singleStatus;
  int index = -1; // to begin with no selection
  int get selectedIndex => index;

  StatusProvider() {
    _statusRepository = StatusRepository();
    fetchAllStatus();
  }

  ApiResponse<List<Status>> get allStatus => _statusList;
  ApiResponse<Status> get singleStatus => _singleStatus;
  changeStatus({required int selectedIndex}) {
    index = selectedIndex;
    notifyListeners();
  }

  Future<void> fetchAllStatus() async {
    _statusList = ApiResponse.loading("loading");
    try {
      final response = await _statusRepository.getAllStatus();
      _statusList = ApiResponse.completed([...?response]);
      notifyListeners();
    } catch (e) {
      _statusList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> fetchSingleStatus({required String id}) async {
    print("Fetching************************$id");
    _singleStatus = ApiResponse.loading("loading");
    try {
      final response = await _statusRepository.getSingleStatus(id: id);
      _singleStatus = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _singleStatus = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
