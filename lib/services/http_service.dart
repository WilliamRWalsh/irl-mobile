import 'package:dio/dio.dart';

class HttpService {
  Dio _dio;

  HttpService() {
    _dio = Dio();

    initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    print('getRequest...');
    Response response;
    try {
      response = await Dio()
          .get('https://my-json-server.typicode.com/typicode/demo/posts');
    } on DioError catch (e) {
      print('error');
      print(e.message);
      throw Exception(e.message);
    }
    print('EXIT getRequest...');
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
        onError: (options, handler) => print(options),
        onResponse: (options, handler) => print('Response: ${options.data}'),
        onRequest: (options, handler) =>
            {print('Request: ${options.path} ${options.data}')}));
  }
}
