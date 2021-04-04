import 'package:task1/Model/person.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  Future<List<Result>> fetchResult(int page) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/person/popular?api_key=6557d01ac95a807a036e5e9e325bb3f0&language=en-US&page=${page}"));
    if (response.statusCode == 200) {
      return List<Result>.from((json.decode(response.body)["results"] as List)
          .map((e) => Result.fromJson((e)))).toList();
    } else {
      throw Exception('FAILED TO LOAD RESULT');
    }
  }
}
