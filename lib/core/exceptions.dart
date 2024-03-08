import 'dart:convert';

import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final int statusCode;
  final Map<String, dynamic> body;

  ServerException({required this.statusCode, required this.body});

  factory ServerException.fromHttpResponse(http.Response response) {
    return ServerException(
      statusCode: response.statusCode,
      body: response.body.isEmpty
          ? {}
          : json.decode(response.body) as Map<String, dynamic>,
    );
  }
}
