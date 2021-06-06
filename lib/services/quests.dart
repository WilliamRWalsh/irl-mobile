import 'package:irl_mobile/models/questsModel.dart';
import 'http_service.dart';

Future<Quests> fetchQuests() async {
  final HttpService httpService = HttpService();
  final response = await httpService.getRequest('typicode/demo/posts');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return null;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
