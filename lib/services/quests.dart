import 'package:irl_mobile/models/questsModel.dart';
import 'http_service.dart';

Future<Quest> fetchQuests() async {
  final response = await HttpService()
      .getRequest('https://my-json-server.typicode.com/typicode/demo/posts');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Quest.fromJson(response.data);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
