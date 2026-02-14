import 'package:dio/dio.dart';

import '../../utils/constants/app_constants.dart';

class ApiClient {
  final Dio _client;

  ApiClient({Dio? client})
      : _client =
            client ??
            Dio(
              BaseOptions(
                baseUrl: AppConstants.baseUrl,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ),
            );

  Future<dynamic> get(String path) async {
    try {
      final response = await _client.get(path);
      return response.data;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      throw Exception('GET $path failed: $statusCode');
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    try {
      final response = await _client.post(path, data: body);
      return response.data;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMsg = statusCode == 401
          ? 'Invalid credentials'
          : 'Request failed with status $statusCode';
      throw Exception(errorMsg);
    }
  }
}


