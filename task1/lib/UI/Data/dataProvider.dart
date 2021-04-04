import 'package:flutter/foundation.dart';
import 'package:task1/Model/person.dart';
import 'package:task1/services/repo.dart';

class DataProvider extends ChangeNotifier {
  int page = 1;
  List<Result> result = [];
  Repository repo = Repository();
  DataProvider() {
    getData();
  }
  void getData() async {
    List<Result> newData = await repo.getResult(page);
    result = [...result, ...newData];
    notifyListeners();
    page++;
  }
}
