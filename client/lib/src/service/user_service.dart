import 'dart:convert';

import 'package:shared/shared.dart';
import 'package:http/http.dart' as http;

const _baseUrl = 'http://localhost:8080/user';

class UserService {
  Future<User> get(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode > 299 || response.statusCode < 100) {
      throw Exception(response);
    }

    return User.fromJson(jsonDecode(response.body));
  }

  Future<List<User>> getAll() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode > 299 || response.statusCode < 100) {
      throw Exception(response);
    }

    if (response.body.isEmpty) return const [];

    return (jsonDecode(response.body) as List)
        .map((e) => User.fromJson(e))
        .toList();
  }

  Future<User> create(String name) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: name,
    );

    if (response.statusCode > 299 || response.statusCode < 100) {
      throw Exception(response);
    }

    return User.fromJson(jsonDecode(response.body));
  }

  Future<User> update(int id, String name) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/$id?name=$name'),
    );

    if (response.statusCode > 299 || response.statusCode < 100) {
      throw Exception(response);
    }

    return User.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode > 299 || response.statusCode < 100) {
      throw Exception(response);
    }
  }
}
