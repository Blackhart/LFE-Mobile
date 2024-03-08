import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mobile/data/constant.dart';
import 'package:mobile/core/exceptions.dart' show ServerException;
import 'package:mobile/model/poco/budget.dart' as poco;

class Budget {
  static Future<poco.Budget> createBudget(String name) async {
    final uri = Uri.parse(ApiUrl.createBudgetUrl());
    final body = json.encode({'name': name});
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};

    final response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == 201) {
      return poco.Budget.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException.fromHttpResponse(response);
    }
  }

  static Future<void> deleteBudget(String id) async {
    final uri = Uri.parse(ApiUrl.deleteBudgetUrl(id));
    final response = await http.delete(uri);

    if (response.statusCode != 204) {
      throw ServerException.fromHttpResponse(response);
    }
  }

  static Future<poco.Budget> renameBudget(String id, String name) async {
    final uri = Uri.parse(ApiUrl.renameBudgetUrl(id));
    final body = json.encode({'name': name});
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};

    final response = await http.put(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      return poco.Budget.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException.fromHttpResponse(response);
    }
  }

  static Future<List<poco.Budget>> listBudget() async {
    final uri = Uri.parse(ApiUrl.listBudgetUrl());
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body) as List<dynamic>;
      return body.map((dynamic item) {
        return poco.Budget.fromJson(item as Map<String, dynamic>);
      }).toList();
    } else {
      throw ServerException.fromHttpResponse(response);
    }
  }

  static Future<poco.Budget> getBudget(String id) async {
    final uri = Uri.parse(ApiUrl.getBudgetUrl(id));
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return poco.Budget.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException.fromHttpResponse(response);
    }
  }
}
