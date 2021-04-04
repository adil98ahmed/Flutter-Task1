import 'package:task1/Model/person.dart';
import 'package:task1/services/service.dart';

class Repository {
  Service myService = new Service();

  Future<List<Result>> getResult(int page) {
    return myService.fetchResult(page);
  }
}
