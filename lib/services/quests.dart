import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:irl_mobile/models/questsModel.dart';

Future<Album> fetchAlbum() async {
  final response = await http.get(
      Uri.https('https://my-json-server.typicode.com', '/typicode/demo/posts'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
