import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants/app_constants.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String path) async {
    final uri = Uri.parse('${AppConstants.baseUrl}$path');
    final response = await _client.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(response.body);
      return decoded;
    } else {
      throw Exception('GET $path failed: ${response.statusCode}');
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse('${AppConstants.baseUrl}$path');
    
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );


    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(response.body);
      return decoded;
    } else {
      final errorMsg = response.statusCode == 401 
          ? 'Invalid credentials'
          : 'Request failed with status ${response.statusCode}';
      throw Exception(errorMsg);
    }
  }
}


