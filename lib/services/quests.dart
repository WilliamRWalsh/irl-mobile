import 'package:irl_mobile/models/questModel.dart';
import 'http_service.dart';
import 'dart:convert';

Future<Quest> fetchQuests() async {
  final HttpService httpService = HttpService();
  final response = await httpService.getRequest('typicode/demo/posts');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Quest.fromJson(jsonDecode(response.data));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
