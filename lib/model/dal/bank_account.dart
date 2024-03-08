import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mobile/data/constant.dart';
import 'package:mobile/core/exceptions.dart' show ServerException;
import 'package:mobile/model/poco/bank_account.dart' as poco;

class BankAccount {
  static Future<poco.BankAccount> createBankAccount(
      String name, String type, double balance) async {
    final uri = Uri.parse(ApiUrl.createBankAccountUrl());
    final body = jsonEncode({'name': name, 'type': type, 'balance': balance});
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};

    final response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == 201) {
      return poco.BankAccount.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException.fromHttpResponse(response);
    }
  }

  static Future<void> deleteBankAccount(String id) async {
    final uri = Uri.parse(ApiUrl.deleteBankAccountUrl(id));
    final response = await http.delete(uri);

    if (response.statusCode != 204) {
      throw ServerException.fromHttpResponse(response);
    }
  }

  static Future<poco.BankAccount> renameBankAccount(
      String id, String name) async {
    final uri = Uri.parse(ApiUrl.renameBankAccountUrl(id));
    final body = json.encode({'name': name});
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};

    final response = await http.put(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      return poco.BankAccount.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException.fromHttpResponse(response);
    }
  }

  static Future<List<poco.BankAccount>> listBankAccount() async {
    final uri = Uri.parse(ApiUrl.listBankAccountUrl());
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body) as List<dynamic>;
      return body.map((dynamic item) {
        return poco.BankAccount.fromJson(item as Map<String, dynamic>);
      }).toList();
    } else {
      throw ServerException.fromHttpResponse(response);
    }
  }

  static Future<poco.BankAccount> getBankAccount(String id) async {
    final uri = Uri.parse(ApiUrl.getBankAccountUrl(id));
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return poco.BankAccount.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException.fromHttpResponse(response);
    }
  }
}
